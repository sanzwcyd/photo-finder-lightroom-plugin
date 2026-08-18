local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrFunctionContext = import 'LrFunctionContext'
local LrBinding = import 'LrBinding'
local LrPathUtils = import 'LrPathUtils'
local LrTasks = import 'LrTasks'
local LrPrefs = import 'LrPrefs'
local LrHttp = import 'LrHttp'

local Localization = require 'Localization'

local PLUGIN_VERSION = "v1.2.0"
local DEFAULT_LANGUAGE = "en"

-- Link kredit yang tampil di dialog "About"
local LINK_GITHUB = "https://github.com/sanzwcyd"
local LINK_INSTAGRAM = "https://www.instagram.com/sanz.arw/"
local LINK_X = "https://x.com/LineBezier"
local LINK_SAWERIA = "https://saweria.co/sanzwcyd"

local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

local function stripExtAndLower(name)
	local noExt = LrPathUtils.removeExtension(name)
	return noExt:lower()
end

-- Pisahkan input jadi daftar nama file bersih (dipakai saat tombol cari ditekan)
local function parseFileList(text)
	local result = {}
	if not text then return result end
	for line in text:gmatch("[^\r\n]+") do
		local t = trim(line)
		if t ~= "" then
			t = t:gsub('^"(.*)"$', '%1')
			table.insert(result, t)
		end
	end
	return result
end

-- Auto-sortir: apapun bentuk paste-annya (dipisah koma, titik-koma, tab,
-- atau beberapa spasi seperti hasil copy dari Excel/kolom), otomatis
-- diubah jadi satu nama per baris.
local function autoFormatList(text)
	if not text or text == "" then return text end
	local t = text
	t = t:gsub("[,;]+", "\n")
	t = t:gsub("[ \t][ \t]+", "\n")
	t = t:gsub("\r\n", "\n")
	t = t:gsub("\n+", "\n")

	local lines = {}
	for line in t:gmatch("[^\n]*") do
		local trimmed = trim(line)
		if trimmed ~= "" then
			table.insert(lines, trimmed)
		end
	end
	return table.concat(lines, "\n")
end

LrTasks.startAsyncTask(function()
	LrFunctionContext.callWithContext("photoFinderDialog", function(context)
		local catalog = LrApplication.activeCatalog()
		local prefs = LrPrefs.prefsForPlugin()

		local props = LrBinding.makePropertyTable(context)
		props.fileListText = ""
		props.searchScope = "all"
		props.applyColorLabel = true
		props.colorLabel = "red"
		props.applyRating = false
		props.ratingValue = 5
		-- Bahasa UI plugin ini disimpan terpisah (LrPrefs), TIDAK mengikuti
		-- setting bahasa aplikasi Lightroom Classic itu sendiri.
		props.language = prefs.language or DEFAULT_LANGUAGE

		-- Setiap kali user mengetik/paste, rapikan otomatis jadi satu nama per baris
		props:addObserver('fileListText', function(properties, key, newValue)
			local formatted = autoFormatList(newValue)
			if formatted ~= newValue then
				properties.fileListText = formatted
			end
		end)

		-- Simpan pilihan bahasa supaya diingat untuk sesi berikutnya
		props:addObserver('language', function(properties, key, newValue)
			prefs.language = newValue
		end)

		local function t(key)
			return Localization.get(props.language, key)
		end

		-- Binding dinamis: label ikut berubah langsung saat dropdown bahasa diganti
		local function bindText(key)
			return LrView.bind {
				key = 'language',
				transform = function(value)
					return Localization.get(value, key)
				end,
			}
		end

		local f = LrView.osFactory()

		-- Isi dropdown ini dibuat "hidup": items = LrView.bind dengan transform,
		-- jadi otomatis diterjemahkan ulang setiap kali bahasa diganti,
		-- bukan cuma dihitung sekali saat dialog pertama dibuka.
		local function colorItemsFor(languageCode)
			return {
				{ title = Localization.get(languageCode, "color_red"), value = "red" },
				{ title = Localization.get(languageCode, "color_yellow"), value = "yellow" },
				{ title = Localization.get(languageCode, "color_green"), value = "green" },
				{ title = Localization.get(languageCode, "color_blue"), value = "blue" },
				{ title = Localization.get(languageCode, "color_purple"), value = "purple" },
			}
		end

		local function ratingItemsFor(languageCode)
			local items = {}
			local formatStr = Localization.get(languageCode, "rating_format")
			for i = 1, 5 do
				table.insert(items, { title = string.format(formatStr, i), value = i })
			end
			return items
		end

		local function sourceItemsFor(languageCode)
			return {
				{ title = Localization.get(languageCode, "source_all"), value = "all" },
				{ title = Localization.get(languageCode, "source_target"), value = "target" },
			}
		end

		local function bindItems(itemsForFn)
			return LrView.bind {
				key = 'language',
				transform = function(value)
					return itemsForFn(value)
				end,
			}
		end

		local languageMenuItems = {}
		for _, lang in ipairs(Localization.languages) do
			table.insert(languageMenuItems, { title = lang.title, value = lang.code })
		end

		local contents = f:column {
			bind_to_object = props,
			spacing = f:control_spacing(),

			f:static_text {
				title = bindText("textbox_instruction"),
				width = 480,
			},
			f:edit_field {
				value = LrView.bind("fileListText"),
				width = 480,
				height = 130,
				multiline = true,
			},

			f:separator { fill_horizontal = 1 },

			f:static_text { title = bindText("source_question") },
			f:row {
				f:static_text { title = bindText("source_label"), width = 90 },
				f:popup_menu {
					value = LrView.bind("searchScope"),
					items = bindItems(sourceItemsFor),
					width = 320,
				},
			},

			f:static_text { title = bindText("mark_question") },
			f:row {
				f:checkbox {
					value = LrView.bind("applyColorLabel"),
					width = 20,
				},
				f:static_text { title = bindText("color_label"), width = 60 },
				f:popup_menu {
					value = LrView.bind("colorLabel"),
					items = bindItems(colorItemsFor),
					enabled = LrView.bind("applyColorLabel"),
					width = 200,
				},
			},
			f:row {
				f:checkbox {
					value = LrView.bind("applyRating"),
					width = 20,
				},
				f:static_text { title = bindText("rating_label"), width = 60 },
				f:popup_menu {
					value = LrView.bind("ratingValue"),
					items = bindItems(ratingItemsFor),
					enabled = LrView.bind("applyRating"),
					width = 200,
				},
			},

			f:separator { fill_horizontal = 1 },

			f:row {
				f:static_text { title = "version " .. PLUGIN_VERSION, font = "<system/small>" },
			},
			f:row {
				f:static_text { title = bindText("language_label"), width = 90 },
				f:popup_menu {
					value = LrView.bind("language"),
					items = languageMenuItems,
					width = 180,
				},
				f:push_button {
					title = bindText("about_label"),
					action = function()
						LrFunctionContext.callWithContext("photoFinderAbout", function(aboutContext)
							local af = LrView.osFactory()

							local function openLink(url)
								return function()
									LrHttp.openUrlInBrowser(url)
								end
							end

							local aboutContents = af:column {
								spacing = af:control_spacing(),

								af:row {
									af:static_text {
										title = "\226\147\152",
										font = "<system/bold>",
									},
									af:static_text {
										title = t("about_title"),
										font = "<system/bold>",
									},
								},

								af:static_text { title = "Photo Finder & Auto Filter" },
								af:static_text { title = t("version_prefix") .. " " .. PLUGIN_VERSION },

								af:static_text {
									title = t("about_body"),
									width = 380,
									height_in_lines = 3,
								},

								af:static_text {
									title = "\226\128\156" .. t("about_quote") .. "\226\128\157\n\226\128\148 sanz",
									width = 380,
									height_in_lines = 2,
								},

								af:separator { fill_horizontal = 1 },

								af:row {
									af:push_button { title = "Github", action = openLink(LINK_GITHUB) },
									af:push_button { title = "Instagram", action = openLink(LINK_INSTAGRAM) },
									af:push_button { title = "X", action = openLink(LINK_X) },
								},

								af:static_text { title = t("about_support_label"), font = "<system/bold>" },
								af:push_button { title = "saweria", action = openLink(LINK_SAWERIA) },
							}

							LrDialogs.presentModalDialog {
								title = t("about_title"),
								contents = aboutContents,
								actionVerb = t("about_close"),
								cancelVerb = "< exclude >",
							}
						end)
					end,
				},
			},
			f:row {
				f:static_text {
					title = bindText("language_hint"),
					width = 480,
					font = "<system/small>",
				},
			},
		}

		local result = LrDialogs.presentModalDialog {
			title = t("dialog_title"),
			contents = contents,
			actionVerb = t("action_verb"),
			cancelVerb = t("cancel_verb"),
		}

		if result ~= "ok" then
			return
		end

		if not props.applyColorLabel and not props.applyRating then
			LrDialogs.message(t("dialog_title"), t("warn_no_criteria"), "info")
			return
		end

		local wantedNames = parseFileList(props.fileListText)
		if #wantedNames == 0 then
			LrDialogs.message(t("dialog_title"), t("warn_empty_list"), "info")
			return
		end

		local wantedSet = {}
		for _, name in ipairs(wantedNames) do
			wantedSet[stripExtAndLower(name)] = true
		end

		local photosToSearch
		if props.searchScope == "target" then
			photosToSearch = catalog:getTargetPhotos()
		else
			photosToSearch = catalog:getAllPhotos()
		end

		local matchedPhotos = {}
		local matchedKeys = {}

		for _, photo in ipairs(photosToSearch) do
			local fileName = photo:getFormattedMetadata('fileName')
			if fileName then
				local key = stripExtAndLower(fileName)
				if wantedSet[key] then
					table.insert(matchedPhotos, photo)
					matchedKeys[key] = true
				end
			end
		end

		local notFound = {}
		for _, name in ipairs(wantedNames) do
			local key = stripExtAndLower(name)
			if not matchedKeys[key] then
				table.insert(notFound, name)
			end
		end

		if #matchedPhotos == 0 then
			local scopeDesc = (props.searchScope == "target") and t("scope_target_desc") or t("scope_all_desc")
			LrDialogs.message(t("dialog_title"), string.format(t("warn_no_match"), scopeDesc), "info")
			return
		end

		catalog:withWriteAccessDo("Photo Finder - Tag Photos", function()
			for _, photo in ipairs(matchedPhotos) do
				if props.applyColorLabel then
					photo:setRawMetadata('colorNameForLabel', props.colorLabel)
				end
				if props.applyRating then
					photo:setRawMetadata('rating', props.ratingValue)
				end
			end
		end)

		catalog:setSelectedPhotos(matchedPhotos[1], matchedPhotos)

		-- Ringkasan hasil
		local summary = string.format(t("result_summary"), #matchedPhotos, #notFound)

		if #notFound > 0 then
			local previewCount = math.min(#notFound, 20)
			local listPreview = table.concat(notFound, "\n", 1, previewCount)
			if #notFound > 20 then
				listPreview = listPreview .. "\n" .. string.format(t("result_notfound_more"), #notFound - 20)
			end
			summary = summary .. "\n\n" .. t("result_notfound_header") .. "\n" .. listPreview
		end

		-- Panduan lokasi filter, disesuaikan dengan kriteria yang benar-benar dipakai
		local guideLines = { "", t("filter_guide_intro"), t("filter_guide_steps") }
		if props.applyColorLabel then
			local colorTitleKey = "color_" .. props.colorLabel
			table.insert(guideLines, string.format(t("filter_guide_color_line"), t(colorTitleKey)))
		end
		if props.applyRating then
			table.insert(guideLines, string.format(t("filter_guide_rating_line"), props.ratingValue))
		end
		table.insert(guideLines, "")
		table.insert(guideLines, t("filter_guide_note"))

		summary = summary .. "\n" .. table.concat(guideLines, "\n")

		LrDialogs.message(t("result_title"), summary, "info")
	end)
end)

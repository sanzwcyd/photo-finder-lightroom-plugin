return {

	LrSdkVersion = 6.0,
	LrSdkMinimumVersion = 5.0,

	LrToolkitIdentifier = 'com.photofinder.lightroom.plugin',
	LrPluginName = "Photo Finder & Auto Filter",

	-- Menu item ini akan muncul di: Library menu > Plug-in Extras > Photo Finder - Cari & Tandai Foto
	LrLibraryMenuItems = {
		{
			title = "Photo Finder - Cari & Tandai Foto",
			file = "PhotoFinderMain.lua",
		},
	},

	VERSION = { major = 1, minor = 0, revision = 0, build = 1 },

}

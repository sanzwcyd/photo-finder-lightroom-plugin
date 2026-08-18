PHOTO FINDER & AUTO FILTER — Lightroom Classic Plugin
=======================================================

INSTALLATION
1. Extract this zip file. You'll get a folder named "PhotoFinder.lrplugin".
   Make sure the name still ends with ".lrplugin" (don't rename it).
2. Open Lightroom Classic > File > Plug-in Manager.
3. Click the "Add" button (bottom left), then select the "PhotoFinder.lrplugin" folder.
4. Make sure the plugin status shows "Installed and running" (green).
5. Click "Done".

HOW TO USE
1. Open your Lightroom catalog as usual.
2. Open the menu: Library > Plug-in Extras > "Photo Finder - Cari & Tandai Foto".
3. Paste the file-name list from your client into the text box provided.
   - One name per line, or separated by commas — either works.
   - Names can include the extension (e.g. DSC_1023.jpg) or not
     (e.g. DSC_1023) — the plugin automatically matches regardless of
     extension or letter case.
4. Choose the search scope:
   - "All Photographs" — searches every photo ever imported into the catalog.
   - "Currently displayed photos (target)" — searches only the active
     grid/filmstrip (e.g. already filtered to a specific folder).
5. Choose the Color Label you want (default: Red), and optionally enable
   Star Rating (1–5 stars).
6. Click "Search".
7. The plugin will:
   - Tag every matching photo with your chosen Color Label / Star Rating.
   - Automatically select those photos in the Library grid.
   - Show a summary: how many photos were found, and a list of any file
     names that were NOT found in the catalog — useful for spotting typos
     or photos that haven't been imported yet.

NEXT STEP (FILTERING IN LIGHTROOM)
Once the photos are tagged, use Lightroom's built-in Library Filter at the
top of the grid (View > Show Filter Bar, or press "\\"), then filter by
Attribute > Color Label / Rating accordingly to see only your client's
selected photos.

LANGUAGE
This plugin has its own language setting, separate from your Lightroom
Classic application language. There's a "Language" dropdown at the bottom
of the dialog, with these options: English (default), Bahasa Indonesia,
Bahasa Melayu, ภาษาไทย, Tiếng Việt, Filipino, Simplified Chinese,
Traditional Chinese, Español, 日本語, العربية, Português, 한국어, and
Français. Your language choice is remembered automatically for next time.
Note: Lightroom's own menu names (e.g. "Attribute", "Color Label") still
follow your Lightroom application's own language, so they may be worded
slightly differently from the plugin's text — the plugin shows a small
note about this on the results screen.

Translations other than Indonesian and English were produced with AI
assistance; for production use or international teams, we recommend
having a native speaker review each language before wider rollout.

MID-SESSION LANGUAGE-SWITCH LIMITATION
If you change the language WHILE the dialog is already open, most of the
text (instructions, labels, the Source/Color/Rating dropdown contents)
updates instantly. However, the window title and the Search/Cancel
buttons at the bottom keep using whichever language was active WHEN the
dialog was first opened — this is a built-in Lightroom SDK limitation
(those two elements are controlled natively by Lightroom, not part of the
view that can be refreshed live). Workaround: click Cancel, then reopen
Photo Finder — next time, the entire dialog, including the title and
buttons, will automatically match the language you last selected (since
your language choice is always remembered).

ABOUT BUTTON & CREDITS
Click the "about" button (next to the Language dropdown) to open a credits
window containing: a short plugin description, a short quote, and buttons
for Github, Instagram, X, and Saweria. Since plain text in the Lightroom
SDK can't be turned into a clickable hyperlink like on Instagram, each
platform name is built as a BUTTON — clicking it automatically opens the
matching link in your default browser.

TECHNICAL NOTES
- This plugin uses Adobe's official Lightroom SDK (Lua): LrApplication,
  LrDialogs, LrView, LrBinding, LrPathUtils, LrTasks.
- File-name matching is based on the file name (excluding the folder
  path), ignoring the extension, and is not case-sensitive.
- Metadata tagging is done via catalog:withWriteAccessDo, following the
  official Lightroom SDK requirements for catalog changes.

CUSTOMIZING THE PLUGIN
All the logic lives in one file: PhotoFinderMain.lua — easy to edit if
your editing team wants to add other options (e.g. auto-adding a Keyword,
or matching based on a partial name/substring).


====================================================================================

PHOTO FINDER & AUTO FILTER — Plugin Lightroom Classic
=======================================================

CARA INSTAL
1. Ekstrak file zip ini. Anda akan mendapat folder bernama "PhotoFinder.lrplugin".
   Pastikan namanya tetap diakhiri ".lrplugin" (jangan diubah).
2. Buka Lightroom Classic > File > Plug-in Manager.
3. Klik tombol "Add" (kiri bawah), lalu pilih folder "PhotoFinder.lrplugin".
4. Pastikan status plugin menjadi "Installed and running" (hijau).
5. Klik "Done".

CARA PAKAI
1. Buka katalog Lightroom seperti biasa.
2. Buka menu: Library > Plug-in Extras > "Photo Finder - Cari & Tandai Foto".
3. Tempel (paste) daftar nama file dari klien ke kotak teks yang tersedia.
   - Boleh satu nama per baris, atau dipisah koma.
   - Boleh dengan ekstensi (contoh: DSC_1023.jpg) atau tanpa ekstensi
     (contoh: DSC_1023) — plugin otomatis mencocokkan tanpa memedulikan ekstensi
     dan tanpa memedulikan huruf besar/kecil.
4. Pilih ruang pencarian:
   - "Seluruh katalog" — mencari ke semua foto yang pernah diimpor.
   - "Foto yang sedang ditampilkan (target)" — mencari hanya di grid/filmstrip
     yang sedang aktif (misalnya sudah difilter ke folder tertentu).
5. Pilih Color Label yang diinginkan (default: Merah), dan opsional aktifkan
   Star Rating (1–5 bintang).
6. Klik "Cari & Tandai".
7. Plugin akan:
   - Menandai semua foto yang cocok dengan Color Label / Star Rating pilihan Anda.
   - Otomatis memilih (select) foto-foto tersebut di Library grid.
   - Menampilkan ringkasan: berapa foto ditemukan, dan daftar nama file (jika ada)
     yang TIDAK ditemukan di katalog — berguna untuk mengecek typo atau foto
     yang belum diimpor.

LANGKAH SETELAHNYA (FILTER DI LIGHTROOM)
Setelah foto ditandai, gunakan Library Filter bawaan Lightroom di bagian atas
grid (View > Show Filter Bar, atau tekan "\\") lalu filter berdasarkan
Attribute > Color Label / Rating yang sesuai, untuk melihat hanya foto pilihan
klien tersebut.

BAHASA (LANGUAGE)
Plugin ini punya pilihan bahasa sendiri, terpisah dari bahasa aplikasi
Lightroom Classic-mu. Ada dropdown "Language" di bagian bawah dialog,
dengan pilihan: English (default), Bahasa Indonesia, Bahasa Melayu,
ภาษาไทย, Tiếng Việt, Filipino, 简体中文, 繁體中文, Español, 日本語,
العربية, Português, 한국어, dan Français. Pilihan bahasa otomatis diingat
untuk sesi berikutnya. Catatan: nama menu Lightroom sendiri (misalnya
"Attribute", "Color Label") tetap mengikuti bahasa aplikasi Lightroom-mu,
jadi bisa sedikit berbeda penyebutannya dari teks di plugin ini — plugin
akan menampilkan catatan kecil soal ini di layar hasil.

Terjemahan di luar Bahasa Indonesia dan Inggris dibuat dengan bantuan AI;
untuk penggunaan produksi/tim internasional, disarankan direview sekali
lagi oleh penutur asli masing-masing bahasa sebelum dipakai secara luas.

KETERBATASAN GANTI BAHASA DI TENGAH SESI
Kalau kamu ganti bahasa SAAT dialog sedang terbuka, sebagian besar teks
(instruksi, label, isi dropdown Source/Color/Rating) langsung berubah
seketika. Tapi judul jendela dan tombol Cari/Cancel di pojok bawah tetap
memakai bahasa yang aktif SAAT dialog itu pertama kali dibuka — ini
keterbatasan bawaan Lightroom SDK (dua elemen itu dikontrol native oleh
Lightroom, bukan bagian tampilan yang bisa diperbarui langsung). Solusinya:
klik Cancel lalu buka Photo Finder lagi — kali berikutnya seluruh dialog,
termasuk judul & tombol, akan otomatis sesuai bahasa terakhir yang kamu
pilih (karena pilihan bahasa selalu diingat/disimpan).

CATATAN TEKNIS
- Plugin ini menggunakan Lightroom SDK (Lua) resmi Adobe: LrApplication,
  LrDialogs, LrView, LrBinding, LrPathUtils, LrTasks.
- Pencocokan nama file dilakukan berdasarkan nama file (tanpa path folder),
  tanpa ekstensi, dan tidak case-sensitive.
- Penandaan metadata dilakukan lewat catalog:withWriteAccessDo sesuai
  ketentuan resmi Lightroom SDK untuk perubahan katalog.

MENYESUAIKAN PLUGIN
Semua logika ada di satu file: PhotoFinderMain.lua — mudah diedit jika tim
editor ingin menambah opsi lain (misalnya menambahkan Keyword otomatis,
atau mencocokkan berdasarkan sebagian nama/substring).

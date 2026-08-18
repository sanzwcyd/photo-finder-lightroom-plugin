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

TOMBOL "ABOUT" & KREDIT
Klik tombol "about" (di sebelah dropdown Language) untuk membuka jendela
kredit berisi: deskripsi singkat plugin, quote singkat, serta tombol
Github, Instagram, X, dan Saweria. Karena teks biasa di Lightroom SDK
tidak bisa dijadikan hyperlink langsung seperti di Instagram, tiap nama
platform itu dibuat sebagai TOMBOL — begitu diklik, otomatis membuka
link terkait di browser default.

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

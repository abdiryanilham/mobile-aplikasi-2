# 📱 Central JavResep

**Central JavResep** adalah aplikasi mobile berbasis Flutter yang menyajikan berbagai resep makanan tradisional khas **Jawa Tengah**, seperti Gudeg, Soto Kudus, Garang Asem, dan masih banyak lagi. Aplikasi ini dirancang dengan pendekatan desain minimalis terinspirasi dari **Tailwind CSS** dan menggunakan **penyimpanan lokal**, tanpa database eksternal.

---

## ✨ Fitur Utama

- 🏠 **Beranda Dinamis**  
  Menampilkan daftar resep tradisional secara interaktif dan responsif.

- 🔎 **Pencarian Resep**  
  Cari resep makanan berdasarkan nama atau kata kunci.

- 📄 **Halaman Detail Resep**  
  Lihat bahan-bahan dan langkah memasak setiap resep secara lengkap.

- ❤️ **Watchlist Lokal**  
  Simpan resep favorit ke dalam daftar tanpa koneksi internet — semua disimpan langsung di perangkat.

- 🎨 **Desain Modern**  
  Tampilan sederhana, bersih, dan ringan dengan pendekatan gaya seperti Tailwind CSS.

---

## 🔧 Teknologi yang Digunakan

- [Flutter](https://flutter.dev/) – Framework UI lintas platform
- **Tailwind-style UI** – Menggunakan pendekatan styling yang konsisten dan modular
- [flutter_svg](https://pub.dev/packages/flutter_svg) – Mendukung ikon SVG tajam dan ringan
- **Local Storage** – Data watchlist disimpan secara lokal (tanpa database eksternal)

---

## 📁 Struktur Folder

lib/
├── models/ # Model data makanan
├── pages/ # Halaman UI: home, search, detail, watchlist
├── widgets/ # Komponen UI seperti FoodCard
├── assets/icon/ # Ikon SVG custom untuk navigasi


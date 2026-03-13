# Laporan Tutorial 5 - Game Development

Pada tugas Tutorial 5 ini, saya telah mengimplementasikan pembuatan dan integrasi *game asset* berupa animasi *spritesheet* dan audio ke dalam proyek game yang telah dibuat pada Tutorial 3. Seluruh aset dan logika implementasi diintegrasikan ke dalam proyek Tutorial 3.

## Penjelasan Implementasi Assets Creation & Integration

### 1. Animasi Sprite Sheet (AnimatedSprite2D)

**Proses Implementasi:** Node `Sprite2D` pada karakter pemain diubah menjadi `AnimatedSprite2D` untuk mendukung animasi berbasis *spritesheet*. Spritesheet yang digunakan berasal dari paket aset gratis Kenney Platformer Characters. Terdapat empat animasi yang diimplementasikan, yaitu `idle` (diam), `walk` (berjalan), `jump` (melompat), dan `crouch` (berjongkok). 

### 2. Objek Baru: Heart (Hati)

**Proses Implementasi:** Objek Heart dibuat sebagai *scene* terpisah menggunakan node `Area2D` sebagai *root*, dengan *child* node `AnimatedSprite2D` dan `CollisionShape2D`. Aset visual hati diperoleh dengan bantuan Claude AI. Signal `body_entered` pada `Area2D` dihubungkan ke fungsi `_on_body_entered`. Ketika pemain bersentuhan dengan objek Heart, sprite langsung disembunyikan (`visible = false`) dan *collision* dinonaktifkan (`set_deferred("disabled", true)`) agar objek tampak hilang secara instan. Setelah efek suara selesai diputar, node dihapus sepenuhnya menggunakan `queue_free()`.

### 3. Objek Baru: Pohon (Tree)

**Proses Implementasi:** Objek pohon dibuat menggunakan node `AnimatedSprite2D` dan dilengkapi animasi *sway* (bergoyang) menggunakan *spritesheet*. Aset visual pohon diperoleh dengan bantuan Claude AI. Objek pohon diatur memiliki nilai *Z Index* lebih rendah dari pemain sehingga posisinya berada di belakang *layer* karakter pemain secara visual.

### 4. Aset Suara (Audio)

**Proses Implementasi:** Terdapat tiga *Sound Effect* (SFX) yang diimplementasikan ke dalam permainan. Pertama, *Jump Sound* yang diputar setiap kali pemain melakukan lompatan, termasuk *double jump*, melalui pemanggilan `jump_sound.play()` pada kondisi pengecekan input lompat. Kedua, *Dash Sound* yang diputar setiap kali pemain melakukan *dash* melalui mekanisme *double tap*, dipanggil di dalam blok kondisi deteksi *double tap* untuk arah kiri maupun kanan. Ketiga, *Heart Sound* yang diputar ketika pemain mengambil objek Heart, menggunakan `await heart_sound.finished` agar node tidak langsung dihapus sebelum suara selesai.

### 5. Background Music (BGM)

**Proses Implementasi:** BGM diambil dari *soundtrack* game *Clair Obscur: Expedition 33*. Audio diimplementasikan menggunakan node `AudioStreamPlayer2D` (bukan `AudioStreamPlayer` biasa) agar mendukung sistem audio berbasis posisi. Properti *Autoplay* diaktifkan agar musik langsung diputar saat *scene* dibuka. Untuk membuat BGM *looping*, file audio diatur ulang melalui tab **Import** dengan mengaktifkan opsi *loop* kemudian melakukan *reimport*.

### 6. Sistem Audio Relatif Terhadap Posisi Objek

**Proses Implementasi:** Dengan memanfaatkan node `AudioStreamPlayer2D`, volume BGM secara otomatis berkurang ketika pemain semakin menjauh dari posisi node BGM, dan semakin keras ketika pemain mendekat. Node `AudioListener2D` ditambahkan sebagai *child* dari node *Player* dan diaktifkan sebagai *listener* utama melalui opsi **Make Current** di Inspector. Konfigurasi yang digunakan adalah *Max Distance* sebesar 2000 px dan nilai *Attenuation* sebesar 1.0.

## Referensi

- Modul Tutorial 5 Game Development, Fakultas Ilmu Komputer Universitas Indonesia.
- [Kenney Platformer Characters](https://kenney.nl/assets/platformer-pack-redux) — Aset spritesheet karakter pemain.
- Dokumentasi resmi Godot Engine 4.x (Terkait modul `AnimatedSprite2D`, `Area2D`, `AudioStreamPlayer2D`, dan `AudioListener2D`).
- Aset visual Heart dan pohon dibuat dengan bantuan Claude AI (Anthropic).
- BGM: *Clair Obscur: Expedition 33* Original Soundtrack.
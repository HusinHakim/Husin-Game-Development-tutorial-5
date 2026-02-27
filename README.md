# Laporan Tutorial 3 - Game Development

Pada tugas Tutorial 3 ini, saya telah mengimplementasikan mekanika pergerakan dasar `CharacterBody2D` serta menyelesaikan seluruh tantangan pada Latihan Mandiri beserta penambahan fitur *polishing*. Seluruh logika pergerakan diimplementasikan di dalam skrip `Player.gd`.

## Penjelasan Implementasi Mekanika Pergerakan

### 1. Polishing (Arah Hadap Karakter dan Animasi)
**Proses Implementasi:** Untuk meningkatkan kenyamanan visual permainan, saya menambahkan logika pembalikan arah karakter (*sprite flipping*). Logika ini bekerja dengan mengevaluasi nilai `velocity.x`. Apabila karakter bergerak ke sumbu X negatif (`< 0`), maka properti `flip_h` akan dieksekusi menjadi `true`. Selain itu, saya memodifikasi *node* bawaan dari `Sprite2D` menjadi `AnimatedSprite2D` untuk memfasilitasi penggunaan *sprite frames* yang berbeda saat karakter dalam posisi berdiri (`idle`) dan berjongkok (`crouch`).

### 2. Double Jump (Lompatan Ganda)
**Proses Implementasi:** Mekanika ini memungkinkan karakter pemain untuk melompat maksimal dua kali. Saya mendefinisikan variabel `max_jumps` dan sisa lompatan (`jumps_left`). Setiap kali fungsi `is_on_floor()` mendeteksi bahwa karakter sedang berpijak pada lantai, nilai `jumps_left` akan direset kembali menjadi 2. Ketika pemain menekan tombol aksi lompat (`ui_up`) dan batas `jumps_left` masih lebih dari 0, kecepatan vertikal (`velocity.y`) karakter akan dimanipulasi sesuai dengan nilai `jump_speed`, lalu kuota `jumps_left` dikurangi satu.

### 3. Crouching (Berjongkok)
**Proses Implementasi:** Fitur jongkok diaktifkan menggunakan masukan dari tombol panah bawah (`ui_down`). Saat tombol ditekan, skrip akan menginstruksikan *node* `AnimatedSprite2D` untuk memainkan animasi "crouch". Secara bersamaan, kecepatan gerak horizontal karakter dikalikan dengan konstanta `crouch_multiplier` (sebesar 0.5) untuk menyimulasikan perlambatan pergerakan saat berjongkok. Untuk menjaga stabilitas *physics engine* dan menghindari isu *stuttering* akibat perubahan skala *hitbox* secara dinamis, penyelesaian ini difokuskan pada transisi animasi. Saat input tombol dilepas, animasi karakter akan otomatis kembali ke *state* "idle".

### 4. Dashing (Lari Cepat melalui *Double Tap*)
**Proses Implementasi:** Mekanika lari cepat dipicu melalui penekanan ganda (*double tap*) pada tombol arah horizontal. Saya memanfaatkan fungsi `Time.get_ticks_msec()` untuk mengkalkulasi selisih waktu antar masukan pemain. Jika tombol arah yang sama ditekan berulang dalam rentang waktu kurang dari `double_tap_window` (0.3 detik) dan karakter tidak sedang berjongkok, maka variabel `is_dashing` bernilai `true`. Selama kalkulasi `dash_timer` (0.2 detik) berjalan, batas kecepatan gerak karakter diekskalasi hingga 2.5 kali lipat dari kecepatan normal (`dash_multiplier`).

## Referensi
- Modul Tutorial 3 Game Development.
- Dokumentasi resmi Godot Engine 4.x (Terkait modul Input, CharacterBody2D, dan AnimatedSprite2D).
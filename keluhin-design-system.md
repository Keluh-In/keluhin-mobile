# Keluh In — Design System (Mobile / Flutter)

> Sistem desain untuk **aplikasi mobile (Flutter)** pengaduan mahasiswa.
> Repo ini mengonsumsi REST API dari backend Laravel (`keluhin-backend`, repo terpisah).
> Token visual didefinisikan **di repo ini**; yang wajib sinkron lintas-repo hanya **kontrak data** (status enum + auth) — lihat [bagian 9](#9-kontrak-api-backend).

**Stack:** Flutter · Dart · `google_fonts`
**Font:** Poppins · **Warna utama:** `#2563EB` · **Grid:** 4px
**Sumber tunggal token:** `lib/core/constants/` — dilarang hardcode hex/ukuran di luar file token.

> **Catatan sinkronisasi.** Warna brand (`#2563EB`) dan warna status disamakan dengan backend agar konsisten di dashboard admin & mobile. Bila backend mengubah salah satunya, perbarui di sini juga.

---

## Daftar Isi

1. [Prinsip](#1-prinsip)
2. [Warna](#2-warna)
3. [Tipografi](#3-tipografi)
4. [Spacing, Radius & Elevation](#4-spacing-radius--elevation)
5. [Komponen](#5-komponen)
6. [Status Pengaduan](#6-status-pengaduan-domain)
7. [Pola Layar](#7-pola-layar)
8. [Aksesibilitas](#8-aksesibilitas)
9. [Kontrak API Backend](#9-kontrak-api-backend)
10. [Design Tokens (Dart)](#10-design-tokens-dart)

---

## 1. Prinsip

- **Tenang & terpercaya.** Biru dominan; merah hanya untuk aksi destruktif/penolakan.
- **Native mobile.** Area sentuh minimal **44×44px**, layout satu kolom, navigasi bawah.
- **Jelas di atas dekoratif.** Hierarki lewat tipografi + spacing, bukan banyak warna.
- **Konsisten lewat token.** Semua nilai dari token bernama di `lib/core/constants/`, bukan angka acak.

---

## 2. Warna

### Primary — Blue

Skala diturunkan dari brand `#2563EB` (selaras backend).

| Token | Hex | Penggunaan |
|---|---|---|
| `blue-50` | `#EFF6FF` | Background lembut, soft badge |
| `blue-100` | `#DBEAFE` | Background hover halus, avatar |
| `blue-200` | `#BFDBFE` | Border aksen / focus |
| `blue-300` | `#93C5FD` | — |
| `blue-400` | `#60A5FA` | — |
| **`blue-500`** | **`#2563EB`** | **Primary** — tombol, link, ikon aktif |
| `blue-600` | `#1D4ED8` | Hover / pressed |
| `blue-700` | `#1E40AF` | Teks di atas background biru muda |
| `blue-800` | `#1E3A8A` | — |
| `blue-900` | `#172554` | — |

### Neutral — Ink

| Token | Hex | Penggunaan |
|---|---|---|
| `ink-0` | `#FFFFFF` | Permukaan / kartu |
| `ink-50` | `#F7F9FB` | Background halaman |
| `ink-100` | `#EDF1F5` | Background sekunder, divider |
| `ink-200` | `#E5E7EB` | Border default |
| `ink-300` | `#D1D5DB` | Border kuat / outline input |
| `ink-400` | `#94A3B8` | Teks subtle, placeholder, ikon nonaktif |
| `ink-500` | `#6B7280` | Caption, teks muted |
| `ink-600` | `#4B5563` | Teks sekunder |
| `ink-700` | `#374151` | Teks tabel/label |
| `ink-800` | `#1F2937` | — |
| `ink-900` | `#111827` | Teks utama |

### Semantic — Status

Tiap status: warna inti, background lembut, teks gelap. **Identik dengan backend.**

| Status | Inti | Background | Teks |
|---|---|---|---|
| **Menunggu** | `#F59E0B` | `#FFF7ED` | `#C2410C` |
| **Diproses** | `#2563EB` | `#EEF6FF` | `#1D4ED8` |
| **Selesai** | `#16A34A` | `#ECFDF5` | `#047857` |
| **Ditolak** | `#E23D3D` | `#FEF2F2` | `#B91C1C` |

---

## 3. Tipografi

Satu typeface — **Poppins** (via `google_fonts`). Ukuran `sp`/logical px.

| Peran | Ukuran / Line-height | Weight | Catatan |
|---|---|---|---|
| Display | 40 / 48 | 600 | Onboarding, judul utama |
| Heading 1 | 32 / 40 | 600 | Judul layar |
| Heading 2 | 24 / 32 | 600 | Judul section |
| Heading 3 | 20 / 28 | 600 | Judul kartu |
| Body Large | 18 / 28 | 400 | Intro, paragraf penting |
| Body | 16 / 26 | 400 | Teks isi standar |
| Body Small | 14 / 22 | 400 | Deskripsi, metadata |
| Caption | 12 / 18 | 500 | Label, timestamp |
| Button | 16 / 24 | 600 | Teks tombol |

**Weight dipakai:** Regular (400), Medium (500), SemiBold (600).

---

## 4. Spacing, Radius & Elevation

### Spacing (base 4px)

| Token | Nilai |
|---|---|
| `space-1` | 4px |
| `space-2` | 8px |
| `space-3` | 12px |
| `space-4` | 16px |
| `space-5` | 20px |
| `space-6` | 24px |
| `space-8` | 32px |
| `space-10` | 40px |
| `space-12` | 48px |
| `space-16` | 64px |

Padding kartu `space-5` (20px). Jarak antar item list `space-3` (12px). Margin antar section `space-12`–`space-16`.

### Radius

| Token | Nilai | Untuk |
|---|---|---|
| `radius-sm` | 8px | Chip kecil, badge persegi |
| `radius-md` | 12px | Tombol, input |
| `radius-lg` | 16px | Kartu |
| `radius-xl` | 20px | Sheet, modal |
| `radius-2xl` | 28px | Container besar |
| `radius-full` | 999px | Pill, avatar, badge |

### Elevation

| Token | Shadow | Untuk |
|---|---|---|
| `shadow-1` | `0 1px 2px rgba(17,24,39,.06), 0 1px 3px rgba(17,24,39,.08)` | Kartu, list item |
| `shadow-2` | `0 4px 14px rgba(17,24,39,.08)` | Dropdown, popover |
| `shadow-3` | `0 14px 32px rgba(17,24,39,.12)` | Modal, sheet |

---

## 5. Komponen

### Buttons

| Varian | Background | Teks |
|---|---|---|
| Primary | `blue-500` (hover `blue-600`) | putih |
| Secondary | `blue-50` | `blue-700` |
| Outline | putih | `ink-800`, border `ink-300` |
| Ghost | transparan | `ink-700` |
| Danger | `#E23D3D` (hover `#B91C1C`) | putih |

- **Radius** `radius-md`. **Weight** 600. **Disabled** opacity 45%.
- Tinggi minimal **44px** (area sentuh).

### Input & Form

- Border `1.5px ink-300`, radius `radius-md`, padding `11×14px`.
- **Focus:** border `blue-500` + ring `blue-100`/`blue-200`.
- **Error:** border `#E23D3D` + ring merah + hint teks merah.
- Label di atas field, weight 600, warna `ink-800`. Hint `ink-500`.
- Textarea deskripsi: tinggi minimal 96px.

### Chip Kategori

Pill `radius-full`, padding `7×14px`, font 13px / weight 500.
- **Default:** bg `ink-100`, teks `ink-700`.
- **Aktif:** bg `blue-50`, teks `blue-700`, border `1.5px blue-300`.

### StatusBadge

Pill titik berwarna + label. Font ~12.5px / weight 600. Warna dari [bagian 6](#6-status-pengaduan-domain).

### ComplaintCard

Bg `ink-0`, border `1px ink-200`, radius `radius-lg`, shadow `shadow-1`, padding `space-5`.
Isi: judul (H3) + StatusBadge kanan atas, deskripsi (Body Small `ink-600`), footer metadata (avatar + nama + kategori + waktu).

### Navigasi — Bottom nav

3 item (Beranda, Riwayat, Profil). Ikon 22px + label 10px. Aktif `blue-500`, nonaktif `ink-400`.

---

## 6. Status Pengaduan (Domain)

Empat status — **nilai dari backend** (enum `menunggu`/`diproses`/`selesai`/`ditolak`).

| Nilai API | Label tampil | Arti | Warna |
|---|---|---|---|
| `menunggu` | Menunggu | Baru masuk, belum ditangani | Amber |
| `diproses` | Diproses | Sedang ditindaklanjuti | Blue |
| `selesai` | Selesai | Sudah ditangani | Green |
| `ditolak` | Ditolak | Tidak valid / di luar wewenang | Red |

**Aturan:** selalu titik berwarna + label teks, jangan andalkan warna saja.

> **Sinkron backend.** Mapping warna ada di `Helper.statusColor`. Bila backend mengubah nilai enum (mis. `menunggu` → `baru`), ubah mapping di sini sekaligus. Label dirender apa adanya dari API.

---

## 7. Pola Layar

### Beranda mahasiswa

- Header biru (`blue-500`) berisi sapaan + judul, body melengkung naik menutupi tepi header (radius atas `18px`).
- Daftar `ComplaintCard` ringkas: judul + StatusBadge mini + metadata.
- Tombol primary lebar penuh "+ Buat Pengaduan".
- Bottom navigation tetap di bawah.

### Detail / Riwayat / Profil

Satu kolom, kartu + token sama. Form buat pengaduan: input + textarea + chip kategori + tombol primary full-width.

---

## 8. Aksesibilitas

- **Kontras:** `ink-900` di atas putih & putih di atas `blue-500` memenuhi WCAG AA.
- **Status bukan hanya warna:** selalu pasangkan label/ikon.
- **Area sentuh:** minimal 44×44px.
- **Focus terlihat:** elemen interaktif punya focus ring.
- **Hierarki:** lewat ukuran tipografi, bukan hanya tebal/warna.

---

## 9. Kontrak API Backend

Yang **wajib sinkron** dengan `keluhin-backend` (bukan token visual):

- **Auth:** Laravel Sanctum — kirim `Authorization: Bearer <token>`.
- **Status pengaduan:** API mengirim enum apa adanya (`menunggu`/`diproses`/`selesai`/`ditolak`). Mobile memetakan ke warna [bagian 6](#6-status-pengaduan-domain). Label tampil = nilai dari API.
- **Base URL / endpoint:** lihat dokumentasi API backend, bukan dokumen ini.

---

## 10. Design Tokens (Dart)

Token di `lib/core/constants/`, dipakai lewat `AppTheme`. Sumber tunggal — dilarang hardcode hex/ukuran di luar file token.

| File | Isi |
|---|---|
| `app_colors.dart` | skala `blue-50..900`, `ink-0..900`, status `core/bg/text`, alias semantik (`primary`, `background`, `textPrimary`, dll) |
| `app_spacing.dart` | `space1..space16` (4–64px) |
| `app_radius.dart` | `sm 8 / md 12 / lg 16 / xl 20 / xxl 28 / full 999` |
| `app_elevation.dart` | `shadow1/2/3` (`List<BoxShadow>`) |
| `app_typography.dart` | Poppins via `google_fonts`: `display / heading1..3 / bodyLarge / body / bodySmall / caption / button` + `textTheme` |

```dart
class KeluhInColors {
  static const primary     = Color(0xFF2563EB);
  static const primaryHover= Color(0xFF1D4ED8);
  static const primarySoft = Color(0xFFEFF6FF);
  static const textPrimary = Color(0xFF111827);
  static const textMuted   = Color(0xFF6B7280);
  static const border      = Color(0xFFE5E7EB);
  static const surface     = Color(0xFFFFFFFF);
  static const background  = Color(0xFFF7F9FB);
  // status
  static const menunggu = Color(0xFFF59E0B);
  static const diproses = Color(0xFF2563EB);
  static const selesai  = Color(0xFF16A34A);
  static const ditolak  = Color(0xFFE23D3D);
}
```

```dart
// Pemakaian
Text('Judul', style: AppTypography.heading3);
Container(
  padding: const EdgeInsets.all(AppSpacing.space5),
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(AppRadius.lg),
    boxShadow: AppElevation.shadow1,
  ),
);
```

**Komponen reusable:** `CustomButton`, `CustomTextField`, `ComplaintCard`, `StatCard`, `StatusBadge`.

---

*Keluh In Design System (Mobile/Flutter) · Poppins · `#2563EB` — token mobile-native, kontrak data sinkron dengan keluhin-backend.*

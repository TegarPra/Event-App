-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 22 Jan 2025 pada 18.20
-- Versi server: 10.5.27-MariaDB-cll-lve
-- Versi PHP: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teky6584_api_tama`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `refund_policy` text DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `location` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'Upcoming Events'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `date_time`, `refund_policy`, `price`, `status`, `created_at`, `updated_at`, `location`, `img_url`, `category`) VALUES
(3, 'Konser Musik Indie', 'Saksikan penampilan luar biasa dari musisi indie...', '2025-02-25 19:00:00', 'Pengembalian dana tersedia hingga 5 hari sebelum acara.', 'Rp150.000', 'Scheduled', '2025-01-11 21:08:14', '2025-01-22 04:43:20', 'Stadion Utama Gelora, Jakarta', 'assets/images/konser_musik_indie.png', 'Populer'),
(4, 'Festival Kuliner Nusantara', 'Nikmati berbagai macam kuliner khas Indonesia dari...', '2025-03-18 10:00:00', 'Tidak ada pengembalian dana.', 'Rp50.000', 'Scheduled', '2025-01-11 21:08:14', '2025-01-20 23:33:51', 'Lapangan Merdeka, Surabaya', 'assets/images/festival_kuliner.png', 'Populer'),
(5, 'Festival Budaya Nusantara', 'Acara tahunan yang menghadirkan kesenian dan budaya...', '2025-04-12 09:00:00', 'Pengembalian dana tersedia hingga 3 hari sebelum acara.', 'Rp75.000', 'Scheduled', '2025-01-11 21:08:14', '2025-01-22 04:43:34', 'Taman Mini Indonesia Indah, Jakarta', 'assets/images/festival_budaya.png', 'Populer'),
(6, 'Konser Jazz Malam', 'Konser jazz dengan penampilan dari musisi terkenal...', '2025-05-20 20:00:00', 'Tidak ada pengembalian dana.', 'Rp200.000', 'Scheduled', '2025-01-11 21:08:14', '2025-01-11 21:08:14', 'Balai Sarbini, Jakarta', 'assets/images/konser_jazz_malam.png', 'Upcoming Events'),
(7, 'Festival Film Pendek', 'Pemutaran film pendek karya sineas muda berbakat...', '2025-06-15 14:00:00', 'Pengembalian dana tersedia hingga 7 hari sebelum acara.', 'Rp100.000', 'Scheduled', '2025-01-11 21:08:14', '2025-01-11 21:08:14', 'Bioskop XXI, Bandung', 'assets/images/festival_film_pendek.png', 'Upcoming Events');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `event_title` varchar(255) NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'rifat', 'raynor@gmail.com', '$2y$10$WjyO./hTK.hn.MzCvlxDAe4nx8Xx4SPOHU/m26jWj0e3rrvfVWAem'),
(2, 'pratama', 'pratama@gmail.com', '$2y$10$xaICkZcRNKPtvIsa/UBXNewMS6ZRuwhWBpbYJKGZ6mUCHMRr4dG/e'),
(3, 'TEST', 'test@gmail.com', '$2y$10$wCJKfbZ63GP0br/idUQ6DOleL//zzkU1GLJzbk7.HaIcxcc3rfC3S'),
(4, 'TEST', 'test@gmail.com', '$2y$10$qSbd5K12UAbPHFmr472bpO0oHOr2JIbni8KwP9PnYAhxZbBXov7nK');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- 001_init.sql — chạy tự động khi container MariaDB khởi động lần đầu
-- Thiết lập charset mặc định
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 1) Bảo đảm database tồn tại
CREATE DATABASE IF NOT EXISTS `minicloud` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2) Tạo bảng kiểm tra trong DB minicloud
USE `minicloud`;

CREATE TABLE IF NOT EXISTS `bootstrap_check` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `note` VARCHAR(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `bootstrap_check` (`note`) VALUES ('db seeded');

-- Ví dụ: một bảng notes đơn giản
CREATE TABLE IF NOT EXISTS `notes` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `content` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `notes` (`content`) VALUES
('hello from MariaDB'),
('this is a sample note');

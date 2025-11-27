-- 001_init.sql — chạy tự động khi container MariaDB khởi động lần đầu
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 1) DATABASE minicloud 
CREATE DATABASE IF NOT EXISTS `minicloud`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `minicloud`;

-- Bảng kiểm tra bootstrap
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

-- 2) DATABASE studentdb (Mở rộng #3 – bạn đã viết)
CREATE DATABASE IF NOT EXISTS `studentdb`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `studentdb`;

CREATE TABLE IF NOT EXISTS `students` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `student_id` VARCHAR(10) NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `dob` DATE NOT NULL,
  `major` VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Xoá dữ liệu cũ nếu có 
DELETE FROM `students`;

INSERT INTO `students` (`student_id`, `fullname`, `dob`, `major`) VALUES
('SE001', 'Nguyễn Quang Trung', '2004-02-07', 'Software Engineering'),
('DS002', 'Khưu Trùng Dương',  '2003-12-12', 'Data Science'),
('AI003', 'Leo Messi',         '2002-11-05', 'Artificial Intelligence');

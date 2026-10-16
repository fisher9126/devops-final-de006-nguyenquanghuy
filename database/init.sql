-- =============================================================================
--  database/init.sql - Khởi tạo dữ liệu cho đề 006: Quản lý sinh viên
--  MySQL tự chạy file này ở LẦN KHỞI ĐỘNG ĐẦU TIÊN khi được mount vào
--  /docker-entrypoint-initdb.d/  (database và user do biến MYSQL_* tạo sẵn)
-- =============================================================================
SET NAMES utf8mb4;

USE ptit_student_db;

CREATE TABLE IF NOT EXISTS students (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_code    VARCHAR(20) NOT NULL,
    full_name       VARCHAR(100) NOT NULL,
    class_name      VARCHAR(20) NOT NULL,
    major           VARCHAR(100) NOT NULL,
    gpa             DECIMAL(3,2) NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO students (student_code, full_name, class_name, major, gpa) VALUES
    ('B24DCCN001', 'Nguyễn Minh Anh', 'K24CNTT1', 'Công nghệ thông tin', 3.45),
    ('B24DCCN002', 'Trần Quốc Bảo', 'K24CNTT1', 'Công nghệ thông tin', 3.12),
    ('B24DCAT003', 'Lê Thu Hà', 'K24ATTT1', 'An toàn thông tin', 3.68),
    ('B24DCAT004', 'Phạm Đức Huy', 'K24ATTT1', 'An toàn thông tin', 2.95),
    ('B24DCKH005', 'Hoàng Gia Khánh', 'K24KHMT1', 'Khoa học máy tính', 3.8),
    ('B24DCKH006', 'Vũ Ngọc Linh', 'K24KHMT1', 'Khoa học máy tính', 3.27),
    ('B24DCCN007', 'Đặng Hải Nam', 'K24CNTT2', 'Công nghệ thông tin', 3.05),
    ('B24DCCN008', 'Bùi Phương Thảo', 'K24CNTT2', 'Công nghệ thông tin', 3.52);

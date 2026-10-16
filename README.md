# DevOps Final – Đề 006: Quản lý sinh viên

Bộ mã nguồn khởi đầu cho bài thi **DevOps Fundamentals – Cuối kỳ**.
Ứng dụng hiển thị **danh sách sinh viên** lấy từ MySQL thông qua Spring Boot, trả về **dạng JSON** qua Nginx (reverse proxy).

## Kiến trúc

```
Trình duyệt ── http://<IP_máy_chủ>:<APP_PORT>
    ▼
[nginx]  nginx:1.27-alpine        GET /*  → app:8080
    ▼
[app]    Spring Boot 4 (JRE 21)   GET /api/students → mysql:3306
    ▼
[mysql]  mysql:8.0                volume mysql_data, KHÔNG public cổng mysql
```

## Cấu trúc thư mục

Đổi tên thư mục/repository thành `devops-final-de006-<họ-tên>` (ví dụ `devops-final-de006-nguyenvana`).
Dấu ★ là phần sinh viên phải làm.

```
devops-final-de006-nguyenvana/     ← Mã nguồn Spring Boot 4 (Java 21, Gradle) – CÓ SẴN
├── src/main/java/com/ptit/devops/student/   ← Controller, Entity, Repository
├── src/main/resources/application.properties
├── build.gradle                   ← Build ra file build/libs/app.jar
├── settings.gradle
├── Dockerfile                     ← Multi-stage build: Gradle/JDK 21 → JRE 21
├── .dockerignore                  ← CÓ SẴN
├── nginx/default.conf             ← Nginx reverse proxy
├── database/init.sql              ← Bảng students + 8 bản ghi mẫu – CÓ SẴN
├── docker-compose.yml             ← MySQL, Spring Boot và Nginx
├── .github/workflows/ci-cd.yml    ← Build, smoke test, push GHCR và deploy qua SSH
├── student.env                    ← Thông tin sinh viên và cấu hình MySQL/deploy
├── screenshots/                   ← ★ Ảnh minh chứng (Phần 5)
├── submission-content/            ← ★ Toàn bộ tệp minh chứng khi nộp bài
├── .gitignore                     ← CÓ SẴN
└── README.md
```

Các cấu hình cần hoàn tất trước khi chạy:

| File | Việc cần làm |
|------|--------------|
| `student.env` | Điền tài khoản/mật khẩu MySQL; không dùng `root` làm `MYSQL_USER` |
| GitHub Actions Secrets | Thêm `SERVER_HOST`, `SERVER_USER`, `SERVER_SSH_KEY` để bật deploy |
| `screenshots/` | `01-actions.png`, `02-ghcr.png`, `03-compose-ps.png`, `04-website.png` |

`student.env` được workflow đọc trực tiếp và chứa thông tin xác thực dạng văn bản
thuần; repository public sẽ làm lộ các giá trị đã điền. Chỉ dùng thông tin riêng,
dùng một lần cho bài thực hành và rotate ngay sau khi chấm. Thêm public key deploy
vào `~/.ssh/authorized_keys` trên server và lưu private key trong GitHub Secret
`SERVER_SSH_KEY`.

## API của ứng dụng

| Method | Đường dẫn | Mô tả |
|--------|-----------|-------|
| GET | `/api/students` | Danh sách sinh viên |

## Biến môi trường mà ứng dụng cần

| Biến | Ý nghĩa |
|------|---------|
| `DB_HOST`, `DB_PORT` | Địa chỉ MySQL (mặc định `mysql`, `3306`) |
| `DB_NAME`, `DB_USER`, `DB_PASSWORD` | Database và tài khoản kết nối |
| `APP_VERSION` | Phiên bản (truyền vào lúc build image, ví dụ commit SHA) |

## Chạy thử (khi đã hoàn thiện Dockerfile và docker-compose.yml)

```bash
docker compose --env-file student.env up -d --build
docker compose --env-file student.env ps
curl http://localhost:<APP_PORT>/api/students
docker compose --env-file student.env down
```

12.0 Chuẩn bị môi trường

docker compose build --no-cache
→ Build lại toàn bộ image (không dùng cache).

docker compose up -d
→ Khởi động toàn bộ hệ thống ở chế độ nền.

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Networks}}"
→ Kiểm tra trạng thái và network của tất cả container.

12.1 Web Frontend – Home + Blog

curl.exe -I http://localhost:8080/

→ Kiểm thử trang Home của web-frontend-server.

curl.exe -I http://localhost:8080/blog/

→ Kiểm thử trang Blog và route /blog/.

Mở trình duyệt: http://localhost:8080/blog/

→ Xem giao diện blog, kiểm tra liên kết blog1/blog2/blog3.

12.2 Backend Flask API – Kiểm thử cơ bản

curl.exe http://localhost:8085/health

→ Kiểm tra health trực tiếp backend.

curl.exe http://localhost:8085/hello

→ Kiểm thử /hello trực tiếp backend.

curl.exe http://localhost/api/hello

→ Kiểm thử /hello qua API Gateway.

12.3 API /student – Đọc dữ liệu từ MariaDB

curl.exe http://localhost:8085/student

→ Gọi trực tiếp backend để lấy danh sách sinh viên.

curl.exe http://localhost/student/

→ Gọi /student/ qua API Gateway.

12.4 Database MariaDB – Kiểm tra schema và dữ liệu

docker exec -it relational-database-server `
mariadb -uroot -prootpass -e "
SHOW DATABASES;
USE minicloud; SHOW TABLES; SELECT _ FROM notes;
USE studentdb; SHOW TABLES; SELECT _ FROM students;
"
→ Kiểm thử database, bảng, và dữ liệu đã seed qua 001_init.sql.

12.5 Authentication – Keycloak + JWT + /secure

curl.exe -I http://localhost:8081/

→ Kiểm tra Keycloak hoạt động.

curl.exe -I http://localhost:8081/realms/realm_nguyenquangtrung/.well-known/openid-configuration

→ Kiểm thử OpenID Discovery.

curl.exe -X POST "http://localhost:8081/realms/realm_nguyenquangtrung/protocol/openid-connect/token
" -H "Content-Type: application/x-www-form-urlencoded"
-d "client_id=flask-app" -d "grant_type=password"
-d "username=sv01" `
-d "password=sv01@123"
→ Lấy access_token từ Keycloak.

curl.exe http://localhost/api/secure

→ Gọi /secure không token (401).

curl.exe http://localhost/api/secure
-H "Authorization: Bearer abc"
→ Gọi /secure với token sai (400).

curl.exe http://localhost/api/secure
-H "Authorization: Bearer <access_token_sv01>"
→ Gọi /secure với token hợp lệ (200).

12.6 Object Storage – MinIO (API + Console + Object Public)

curl.exe -I http://localhost:9000/

→ Kiểm tra MinIO API.

curl.exe -I http://localhost:9001/

→ Kiểm tra MinIO Console.

curl.exe http://localhost:9000/profile-pics/avatar.jpg
--output avatar_downloaded.jpg
→ Tải object ảnh từ bucket profile-pics.

curl.exe http://localhost:9000/documents/report.pdf
--output report_downloaded.pdf
→ Tải object PDF từ bucket documents.

12.7 Internal DNS – BIND9 (zone cloud.local)

docker exec -it internal-dns-server sh -lc "dig @127.0.0.1 cloud.local SOA +noall +answer"
→ Kiểm thử SOA của zone cloud.local.

docker exec -it internal-dns-server sh -lc "dig @127.0.0.1 web-frontend-server.cloud.local A +noall +answer"
→ Kiểm thử A-record web-frontend-server.cloud.local.

docker exec -it internal-dns-server sh -lc "dig @127.0.0.1 app-backend.cloud.local A +noall +answer"
→ Kiểm thử bản ghi A cho backend.

docker exec -it internal-dns-server sh -lc "dig @127.0.0.1 minio.cloud.local A +noall +answer"
→ Kiểm thử bản ghi A cho MinIO.

docker exec -it internal-dns-server sh -lc "dig @127.0.0.1 keycloak.cloud.local A +noall +answer"
→ Kiểm thử bản ghi A cho Keycloak.

12.8 Prometheus & Node Exporter – Thu thập metrics

curl.exe -I http://localhost:9090/-/healthy

→ Health check Prometheus.

curl.exe -I http://localhost:9090/-/ready

→ Readiness check Prometheus.

curl.exe http://localhost:8080/metrics

→ Kiểm thử endpoint metrics của web frontend.

Mở trình duyệt: http://localhost:9090/targets

→ Kiểm tra trạng thái job web và node.

12.9 Grafana – Dashboard giám sát

curl.exe -I http://localhost:3000/login

→ Kiểm tra UI đăng nhập Grafana.

Mở trình duyệt: http://localhost:3000

→ Xem dashboard System Health.

12.10 API Gateway / Reverse Proxy – Nginx

curl.exe -I http://localhost/

→ Trang Home qua gateway.

curl.exe -I http://localhost/blog/

→ Trang Blog qua gateway.

curl.exe -i http://localhost/api/health

→ Kiểm thử route /api/health.

curl.exe -i http://localhost/api/hello

→ Kiểm thử route /api/hello.

curl.exe -I http://localhost/auth/

→ Proxy đến Keycloak.

curl.exe -I http://localhost/minio/

→ Proxy đến MinIO API.

curl.exe -I http://localhost/minio/console/

→ Proxy đến MinIO Console.

curl.exe http://localhost/student/

→ Route /student/ qua gateway.

12.11 Load Balancer Round Robin – 2 Web Frontend

curl.exe http://localhost/

curl.exe http://localhost/

curl.exe http://localhost/

curl.exe http://localhost/

→ Kiểm thử cân bằng tải Round Robin giữa web-frontend-server và web-frontend-server2.

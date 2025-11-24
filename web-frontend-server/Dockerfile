FROM nginx:stable

# Xoá cấu hình mặc định để tránh đè cấu hình của mình
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy server block và nội dung web tĩnh
COPY conf.default /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/

# Quyền đọc cho nội dung web (an toàn trên Linux container)
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]



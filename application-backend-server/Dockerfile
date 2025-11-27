FROM python:3.11-slim

# RUN apt-get update && apt-get install -y --no-install-recommends tzdata && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Sao chép mã nguồn
COPY . .

# Cài phụ thuộc
RUN pip install --no-cache-dir flask pymysql python-jose

# Biến môi trường & cổng nội bộ
ENV PORT=8081
EXPOSE 8081

# Chạy app
CMD ["python", "app.py"]

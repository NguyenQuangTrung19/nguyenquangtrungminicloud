from flask import Flask, jsonify, request
import os
import json
import pymysql
from jose import jwt

app = Flask(__name__)

# Lấy cổng từ biến môi trường (mặc định 8081, trùng với APP_INTERNAL_PORT)
PORT = int(os.getenv("PORT", "8081"))

@app.get("/secure")
def secure():
    """
    Endpoint bảo vệ bằng JWT (demo).
    - Lấy token từ header Authorization: Bearer <token>
    - Giải mã claim KHÔNG verify chữ ký (đơn giản cho mục đích demo báo cáo)
    """
    auth_header = request.headers.get("Authorization", "")
    if not auth_header.startswith("Bearer "):
        return jsonify({"error": "Missing or invalid Authorization header"}), 401

    token = auth_header.split(" ", 1)[1].strip()

    try:
        # Giải mã claim mà không verify chữ ký (đủ để đọc preferred_username…)
        claims = jwt.get_unverified_claims(token)
        username = claims.get("preferred_username", "unknown")

        return (
            jsonify(
                {
                    "message": "Access granted to secure endpoint",
                    "user": username,
                    "claims": claims,
                }
            ),
            200,
        )
    except Exception as e:
        return jsonify({"error": "Invalid token", "details": str(e)}), 400
    
@app.get("/health")
def health():
    return jsonify({"status": "ok"}), 200


@app.get("/hello")
def hello():
    return jsonify({"message": "hello from backend", "port": PORT}), 200

# Hàm tạo connection tới MariaDB
def get_connection():
    return pymysql.connect(
        host="relational-database-server",
        user="root",
        password="rootpass",
        database="studentdb",
        cursorclass=pymysql.cursors.DictCursor
    )

@app.get("/student")
def student_list():
    try:
        conn = get_connection()
        with conn.cursor() as cursor:
            cursor.execute("SELECT * FROM students")
            data = cursor.fetchall()
        conn.close()
        return jsonify(data), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)
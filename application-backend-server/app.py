from flask import Flask, jsonify
import os
import json

app = Flask(__name__)

# Lấy cổng từ biến môi trường (mặc định 8081, trùng với APP_INTERNAL_PORT)
PORT = int(os.getenv("PORT", "8081"))


@app.get("/health")
def health():
    return jsonify({"status": "ok"}), 200


@app.get("/hello")
def hello():
    return jsonify({"message": "hello from backend", "port": PORT}), 200


@app.get("/student")
def student_list():
    """
    API mở rộng: trả danh sách sinh viên từ file students.json
    Cấu trúc file: list các object {id, name, major, gpa}
    """
    try:
        with open("students.json", encoding="utf-8") as f:
            data = json.load(f)
        return jsonify(data), 200
    except FileNotFoundError:
        return jsonify({"error": "students.json not found"}), 500
    except json.JSONDecodeError:
        return jsonify({"error": "students.json is not valid JSON"}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    # Lắng nghe trên mọi interface trong container
    app.run(host="0.0.0.0", port=PORT)

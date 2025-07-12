from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # penting supaya Flutter bisa akses API dari HP

@app.route('/api/halo', methods=['GET'])
def halo():
    return jsonify({"message": "Halo dari Flask ke Flutter!"})

@app.route('/api/kirim', methods=['POST'])
def kirim():
    data = request.get_json()
    return jsonify({"data_diterima": data})

if __name__ == '__main__':
    app.run(debug=True)

from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="API de Python en Gunicorn funcionando desde un contenedor seguro!")


from flask import Flask, request, jsonify
import json
from flask_cors import CORS, cross_origin
from admin import get_products_bp, set_products_bp, get_set_edit_products_bp
from shop import auth_bp, reg_bp, home_products_bp
from alchemy.model import create_app

app = create_app()
CORS(app, resources={r"/*": {"origins": "http://localhost:4200"}})

app.register_blueprint(get_products_bp)
app.register_blueprint(set_products_bp)
app.register_blueprint(get_set_edit_products_bp)
app.register_blueprint(auth_bp)
app.register_blueprint(reg_bp)
app.register_blueprint(home_products_bp)

if __name__ == "__main__":
    app.run(port=5000)

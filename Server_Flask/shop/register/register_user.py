from flask import Flask, Blueprint, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

from alchemy.entities.users import db_users as db, AccountAdmin, Account

reg_bp = Blueprint("reg", __name__)


@reg_bp.route("/register", methods=["POST", "OPTIONS"])
@cross_origin()
def login():
    data = request.json
    if not data:
        return jsonify({"message": "No data provided"}), 400

    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"message": "Email and password are required"}), 400

    # Проверяем, существует ли уже пользователь с таким email
    existing_user = Account.query.filter_by(login=email).first()
    if existing_user:
        return jsonify({"message": "User with this email already exists"}), 400

    # Хэшируем пароль
    hashed_password = generate_password_hash(password)

    # Создаем новую запись в таблице Account
    new_user = Account(login=email, password=hashed_password)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully"}), 201

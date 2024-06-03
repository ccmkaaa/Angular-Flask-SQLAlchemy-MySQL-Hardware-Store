from flask import Flask, Blueprint, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import check_password_hash

from alchemy.entities.users import db_users as db, AccountAdmin, Account

auth_bp = Blueprint("auth", __name__)


# @auth_bp.route("/login", methods=["POST"])
# def login():
#     data = request.json

#     # Получение данных пользователя из запроса
#     user_login = data.get("email")
#     user_password = data.get("password")

#     # Поиск пользователя в базе данных
#     user = Account.query.filter_by(login=user_login, password=user_password).first()

#     if user:
#         # Пользователь найден, проверяем, является ли он администратором
#         admin_info = AccountAdmin.query.filter_by(id=user.id).first()


#         if admin_info and admin_info.isadmin:
#             # Если пользователь администратор, возвращаем "admin"
#             return jsonify({"token": "admin"}), 200
#         else:
#             # Если пользователь не администратор, возвращаем его логин
#             return jsonify({"token": user.login}), 200
#     else:
#         # Если пользователь не найден или пароль не совпадает, возвращаем ошибку
#         return jsonify({"error": "Failed Login"}), 401
@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.json

    user_login = data.get("email")
    user_password = data.get("password")

    user = Account.query.filter_by(login=user_login).first()

    if user:
        if check_password_hash(user.password, user_password):
            # Пользователь аутентифицирован, проверяем, является ли он администратором
            admin_info = AccountAdmin.query.filter_by(id=user.id).first()

            if admin_info and admin_info.isadmin:
                return jsonify({"token": "admin"}), 200
            else:
                return jsonify({"token": user.login}), 200
        else:
            return jsonify({"error": "Invalid credentials"}), 401
    else:
        return jsonify({"error": "User not found"}), 404

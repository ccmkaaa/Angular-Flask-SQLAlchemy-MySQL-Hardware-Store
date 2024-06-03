from flask import Flask, Blueprint, request, jsonify
from flask_cors import CORS, cross_origin
from flask import send_file
import json

from flask_sqlalchemy import SQLAlchemy
from datetime import datetime


from alchemy.entities.cart import OrderCart, db_cart
from alchemy.entities.products import AllProduct, db_products
from alchemy.entities.users import Account


cart_products_bp = Blueprint("cart_products", __name__)


@cart_products_bp.route("/shop_set_order", methods=["POST", "OPTIONS"])
@cross_origin()
def shop_set_order():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    data = request.json

    user_login = data.get("user_login")
    total_amount = data.get("total_amount")
    products = data.get("products")

    if not products or products == "":
        return jsonify({"message": "No products in the order"}), 400

    # Проверка, достаточно ли товаров в наличии для оформления заказа
    for item in products:
        product_info = item.get("product")
        quantity = item.get("quantity")

        if not product_info or not quantity:
            return jsonify({"message": "Incomplete product information"}), 400

        product_id = product_info.get("id")
        product = AllProduct.query.get(product_id)

        if not product:
            return jsonify({"message": f"Product with ID {product_id} not found"}), 404

        if product.quantity < quantity:
            return (
                jsonify(
                    {
                        "message": f"Not enough quantity available for product {product.name}"
                    }
                ),
                400,
            )

    # Нахождение id аккаунта по логину
    account = Account.query.filter_by(login=user_login).first()
    if not account:
        return jsonify({"message": "User not found"}), 404

    # Создание новой записи в таблице OrderCart
    new_order = OrderCart(
        cart_products=json.dumps(products),  # Сохраняем в виде JSON строки
        id_acc=account.id,
        order_date=datetime.now(),
        total_amount=total_amount,
    )

    # Добавление новой записи в сессию и сохранение изменений в базе данных
    db_cart.session.add(new_order)
    db_cart.session.commit()

    # Обновление количества товаров в таблице AllProduct
    for item in products:
        product_id = item["product"]["id"]
        quantity = item["quantity"]
        product = AllProduct.query.get(product_id)
        if product:
            product.quantity -= quantity

    db_products.session.commit()

    return jsonify({"message": "Order placed successfully"}), 201


@cart_products_bp.route("/shop_get_orders", methods=["POST", "OPTIONS"])
@cross_origin()
def shop_get_orders():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    data = request.json
    user_login = data.get("user_login")

    # Находим пользователя по логину
    account = Account.query.filter_by(login=user_login).first()
    if not account:
        return jsonify({"message": "User not found"}), 404

    # Получаем все заказы, связанные с этим пользователем
    orders = OrderCart.query.filter_by(id_acc=account.id).all()

    # Преобразуем заказы в формат JSON и отправляем клиенту
    orders_data = []
    for order in orders:
        order_data = {
            "id": order.id,
            "order_date": order.order_date,
            "total_amount": order.total_amount,
            "cart_products": json.loads(
                order.cart_products
            ),  # Преобразуем строку JSON в объект Python
        }
        orders_data.append(order_data)

    return jsonify(orders_data), 200

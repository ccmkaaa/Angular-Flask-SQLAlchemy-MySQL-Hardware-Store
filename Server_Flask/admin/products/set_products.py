import mysql.connector
from flask_cors import CORS, cross_origin
from flask import Flask, request, jsonify, Blueprint, abort
from alchemy.entities.products import AllProduct, GPU, CPU, RAM, MB, db_products
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Resource
from sqlalchemy import asc, desc, inspect


set_products_bp = Blueprint("set_products", __name__)


@set_products_bp.route("/set_products_show", methods=["POST", "OPTIONS"])
@cross_origin()
def set_products_show():
    if request.method == "OPTIONS":
        # Обработка предварительного запроса
        return jsonify({"status": "ok"}), 200

    try:
        data = request.get_json()

        # перебираем данные и обновляем существующие объекты AllProduct
        for product_data in data.get("products", []):
            product_id = product_data.get("id")
            product = AllProduct.query.get(product_id)

            if product:  # если объект существует
                product.name = product_data.get("name")
                product.pic = product_data.get("pic")
                product.product_type = product_data.get("product_type")
                product.quantity = product_data.get("quantity")
                product.price = product_data.get("price")
                product.description = product_data.get("description")

        db_products.session.commit()

        return jsonify({"success": True, "message": "Products updated successfully"})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)})

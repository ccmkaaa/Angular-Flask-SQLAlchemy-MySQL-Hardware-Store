import mysql.connector
from flask_cors import CORS, cross_origin
from flask import Flask, request, jsonify, Blueprint, abort
from alchemy.entities.products import AllProduct, GPU, CPU, RAM, MB, db_products
from alchemy.entities.products import (
    GpuBrand,
    GpuCoolers,
    GpuDistributor,
    GpuMemorySize,
)
from alchemy.entities.products import CpuBrand, CpuCores
from alchemy.entities.products import RamBrand, RamCapacity, RamFrequency, RamMemoryType
from alchemy.entities.products import MbFormat, MbSocket, MbWiFi
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Resource
from sqlalchemy import asc, desc, inspect
import sys, os
from werkzeug.utils import secure_filename
from importlib import import_module


get_set_edit_products_bp = Blueprint("get_cats", __name__)


table_models = {
    "gpu": {
        "brand": GpuBrand,
        "coolers": GpuCoolers,
        "distributor": GpuDistributor,
        "memory_size": GpuMemorySize,
    },
    "cpu": {
        "brand": CpuBrand,
        "cores": CpuCores,
    },
    "ram": {
        "brand": RamBrand,
        "capacity": RamCapacity,
        "frequency": RamFrequency,
        "memory_type": RamMemoryType,
    },
    "mb": {
        "format": MbFormat,
        "socket": MbSocket,
        "wi_fi": MbWiFi,
    },
}


@get_set_edit_products_bp.route("/get_table_cats", methods=["POST", "OPTIONS"])
def get_table_cats():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    # ищем таблицу в словаре
    selected_table = request.json.get("selectedTable")
    if selected_table in table_models:
        table_model = table_models[selected_table]
        # создаем список пар "id"-"name" для каждой подтаблицы
        cats_data = {table: get_cats(table_model[table]) for table in table_model}
        # print(f"Cats Data: {cats_data}", file=sys.stderr)
        return jsonify(cats_data)
    else:
        return jsonify({"error": "Table not found"}), 404


def get_cats(model):
    # получаем список имен столбцов в модели
    column_names = [column.name for column in model.__table__.columns]
    # проверяем наличие столбца "name" в модели
    if "name" in column_names:
        # если есть столбец "name", используем его для формирования списка пар "id"-"name"
        cats = model.query.all()
        return [{"id": cat.id, "name": getattr(cat, "name")} for cat in cats]
    else:
        # в противном случае, используем первый столбец для идентификации, а второй как "name"
        cats = model.query.all()
        return [
            {"id": getattr(cat, column_names[0]), "name": getattr(cat, column_names[1])}
            for cat in cats
        ]


@get_set_edit_products_bp.route("/add_edit_product", methods=["POST", "OPTIONS"])
def add_edit_product():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200
    data = request.get_json()
    selected_table = data.get("selectedTable")
    new_product = data.get("newProduct")

    if selected_table and new_product:
        table_model = None
        if selected_table == "gpu":
            table_model = GPU
        elif selected_table == "cpu":
            table_model = CPU
        elif selected_table == "ram":
            table_model = RAM
        elif selected_table == "mb":
            table_model = MB

        if table_model:
            # record
            new_record = table_model(**new_product)
            db_products.session.add(new_record)
            db_products.session.commit()

            # new id
            new_record_id = new_record.id

            # entity by id
            created_record = table_model.query.get(new_record_id)

            return (
                jsonify(
                    {
                        "status": "success",
                        "message": f"New product added to {selected_table}",
                        "createdRecord": created_record.serialize(),
                    }
                ),
                200,
            )

    return jsonify({"error": "Invalid request data"}), 400


@get_set_edit_products_bp.route("/set_edit_product", methods=["POST", "OPTIONS"])
def set_edit_product():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    try:
        new_product_id = int(request.form.get("newProductId"))
        selected_table = request.form.get("selectedTable")
        image_file = request.files.get("imageFile")
        price = int(request.form.get("price"))
        description = request.form.get("description")

        product = AllProduct.query.get(new_product_id)
        if product is not None:
            product.price = price
            product.description = description
            # Загружаем изображение, если передан файл
            if image_file:
                upload_folder = f"src/assets/images/products/{selected_table.lower()}"
                os.makedirs(upload_folder, exist_ok=True)
                new_filename = secure_filename(f"{new_product_id}.jpg")

                image_path = os.path.join(upload_folder, new_filename)
                image_file.save(image_path)

                product.pic = (
                    f"/assets/images/products/{selected_table.lower()}/{new_filename}"
                )

            db_products.session.commit()

            return jsonify({"status": "ok"}), 200
        else:
            return jsonify({"error": "Product not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@get_set_edit_products_bp.route("/delete_edit_product", methods=["POST", "OPTIONS"])
def delete_edit_product():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    data = request.json
    selected_table = data.get("selectedTable").lower()
    product_id = data.get("productId")

    if selected_table == "gpu":
        product = GPU.query.get(product_id)
    elif selected_table == "cpu":
        product = CPU.query.get(product_id)
    elif selected_table == "ram":
        product = RAM.query.get(product_id)
    elif selected_table == "mb":
        product = MB.query.get(product_id)
    else:
        return jsonify({"status": "error", "message": "Invalid table name"}), 400

    if not product:
        return jsonify({"status": "error", "message": "Product not found"}), 404

    try:
        image_path = os.path.join(
            "src",
            "assets",
            "images",
            "products",
            f"{selected_table.lower()}",
            f"{product_id}.jpg",
        )
        if os.path.exists(image_path):
            os.remove(image_path)

        db_products.session.delete(product)
        db_products.session.commit()
        return jsonify({"status": "success", "message": "Product deleted"}), 200
    except Exception as e:
        db_products.session.rollback()
        return jsonify({"status": "error", "message": str(e)}), 500

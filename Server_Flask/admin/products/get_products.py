import mysql.connector
from ..db.conn import db
from flask_cors import CORS, cross_origin
from flask import Flask, request, jsonify, Blueprint, abort
from alchemy.model import AllProduct, GPU, CPU, RAM, MB
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Resource
from sqlalchemy import asc, desc, inspect


get_products_bp = Blueprint("get_products", __name__)


@get_products_bp.route("/get_product_types", methods=["GET"])
@cross_origin()
def get_product_types():
    cursor = db.cursor()

    try:
        query = "SELECT DISTINCT product_type FROM all_product;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify(result)
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        abort(500, description=f"Database error: {err}")
    finally:
        cursor.close()


@get_products_bp.route(
    "/get_product_table",
    methods=["POST", "OPTIONS"],
)
@cross_origin()
def get_product_table():
    if request.method == "OPTIONS":
        # Обработка предварительного запроса
        return jsonify({"status": "ok"}), 200
    data = request.json
    table_type = data.get("selectedTableType", "edit")
    table_name = data.get("selectedProductType", "").lower()

    # В зависимости от типа таблицы выбираем соответствующую модель
    if table_type == "show":
        model = AllProduct
    elif table_type == "edit":
        # Добавьте обработку других типов таблиц, если необходимо
        model = None
        if table_name == "gpu":
            model = GPU
        elif table_name == "cpu":
            model = CPU
        elif table_name == "ram":
            model = RAM
        elif table_name == "mb":
            model = MB
    else:
        return {"error": "Неподдерживаемый тип таблицы"}, 400

    if model:
        if table_type == "show":
            result = (
                model.query.filter_by(product_type=table_name)
                .order_by(asc(AllProduct.id))
                .all()
            )
        else:
            result = model.query.all()

        serialized_result = [item.serialize() for item in result]
        return jsonify(serialized_result)
    else:
        return {"error": "Модель для данного типа таблицы не найдена"}, 404


@get_products_bp.route(
    "/get_columns_table/<selectedTable>",
    methods=["GET", "OPTIONS"],
)
@cross_origin()
def get_columns_table(selectedTable):
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    table_name = selectedTable.lower()
    model = None

    if table_name == "all_product":
        model = AllProduct
    elif table_name == "gpu":
        model = GPU
    elif table_name == "cpu":
        model = CPU
    elif table_name == "ram":
        model = RAM
    elif table_name == "mb":
        model = MB

    if not model:
        return jsonify({"error": "Модель не найдена"})
    inspector = inspect(model)
    columns = [column.name for column in model.__table__.columns]

    return jsonify(columns)


###   вспомогательное


def get_category_columns(table_name):
    cursor = db.cursor()
    try:
        query = f"SHOW columns FROM {table_name}"
        cursor.execute(query)
        columns = [column[0] for column in cursor.fetchall()]
        filtered_columns = filter_columns(columns)

        # Формируем строку с полными именами столбцов
        full_column_names = [f"{table_name}.{column}" for column in filtered_columns]
        result_string = ", ".join(full_column_names)
        return result_string

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        abort(500, description=f"Database error: {err}")
    finally:
        cursor.close()


def filter_columns(columns):
    # Фильтруем столбцы, оставляя только те, которые начинаются с "id_" и не являются "id" или "name"
    filtered_columns = [column for column in columns if column.startswith("id_")]
    return filtered_columns

from flask import Flask, Blueprint, request, jsonify
from flask_cors import CORS, cross_origin
from flask import send_file
from flask_sqlalchemy import SQLAlchemy
from alchemy.entities.products import AllProduct, GPU, CPU, RAM, MB
from alchemy.entities.products import (
    GpuBrand,
    GpuCoolers,
    GpuDistributor,
    GpuMemorySize,
)
from alchemy.entities.products import CpuBrand, CpuCores
from alchemy.entities.products import RamBrand, RamCapacity, RamFrequency, RamMemoryType
from alchemy.entities.products import MbFormat, MbSocket, MbWiFi
from typing import Dict, List
from sqlalchemy.orm import aliased
from sqlalchemy import or_
import sys


home_products_bp = Blueprint("home_products", __name__)

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

table_models_2 = {
    "gpu": GPU,
    "cpu": CPU,
    "ram": RAM,
    "mb": MB,
}


@home_products_bp.route("/shop_get_product_types", methods=["GET"])
@cross_origin()
def shop_get_product_types():
    product_types = [
        {"id": idx, "name": key} for idx, key in enumerate(table_models.keys())
    ]
    return jsonify(product_types)


@home_products_bp.route("/shop_get_products", methods=["GET"])
@cross_origin()
def shop_get_products():
    products = AllProduct.query.all()
    serialized_products = [product.serialize() for product in products]
    return jsonify(serialized_products)


@home_products_bp.route("/shop_get_categories", methods=["GET"])
@cross_origin()
def shop_get_categories():
    categories = []
    for category, subcategories in table_models.items():
        category_data = {"category": category, "subcategories": []}
        for subcategory, model in subcategories.items():
            subcategory_data = {"name": subcategory, "values": []}
            items = model.query.all()
            for item in items:
                subcategory_data["values"].append(
                    {"id": getattr(item, "id"), "name": getattr(item, subcategory)}
                )
            category_data["subcategories"].append(subcategory_data)
        categories.append(category_data)
    return jsonify(categories)


@home_products_bp.route("/shop_get_sorted_product_ids", methods=["POST", "OPTIONS"])
@cross_origin()
def get_sorted_product_ids():
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200

    data = request.get_json()
    categories = data["categoriesDict"]
    search_text = data["searchText"]
    product_types = data["productTypes"]

    # 1.1 Фильтрация по категориям

    all_product_ids = []
    # Итерируемся по категориям и подкатегориям
    for category_name, category_data in categories.items():
        temp_ids = []
        for subcategory_index, subcategory_data in category_data.items():
            # Получаем подкатегорию и её значения
            subcategory_name = subcategory_data["name"]
            values = subcategory_data["values"]

            # Получаем соответствующую модель для данной подкатегории из table_models_2
            model = table_models_2.get(category_name)
            if model is None:
                continue

            # Получаем список id значений подкатегории
            value_ids = [value["id"] for value in values]

            # Фильтруем записи по значениям подкатегории и получаем соответствующие id товаров
            filtered_ids = (
                model.query.with_entities(model.id)
                .filter(getattr(model, f"id_{subcategory_name}").in_(value_ids))
                .all()
            )

            # Добавляем полученные id во временный список
            temp_ids.extend(filtered_ids)

            # # Добавляем полученные id в общий список
            # all_product_ids.extend(filtered_ids)
        # Если временный список не пуст, добавляем его в общий список
        if temp_ids:
            all_product_ids.extend(temp_ids)

    # Преобразуем список в одномерный список
    all_product_ids = [item for sublist in all_product_ids for item in sublist]

    # 1.2. Фильтрация товаров по списку ID
    filtered_products = (
        AllProduct.query.with_entities(AllProduct)
        .filter(AllProduct.id.in_(all_product_ids))
        .all()
    )

    # 2. Фильтрация по типам товаров
    # product_type_names = [product_type["name"] for product_type in product_types]
    # if product_type_names:
    #     filtered_products = (
    #         AllProduct.query.with_entities(AllProduct)
    #         .filter(AllProduct.product_type.in_(product_type_names))
    #         .all()
    #     )
    product_type_names = [product_type["name"] for product_type in product_types]
    if product_type_names:
        # Ограничиваем выборку продуктов по типу продукта
        filtered_products = [
            product
            for product in filtered_products
            if product.product_type in product_type_names
        ]

    # 3. Фильтрация по поиску
    # if search_text:
    #     filtered_products = (
    #         AllProduct.query.with_entities(AllProduct)
    #         .filter(AllProduct.name.ilike("%" + search_text + "%"))
    #         .all()
    #     )
    if search_text:
        # Ограничиваем выборку продуктов по поисковому тексту
        filtered_products = [
            product
            for product in filtered_products
            if search_text.lower() in product.name.lower()
        ]

    # Сортировка товаров
    # Сортировка по типу товара
    filtered_products.sort(key=lambda product: product.product_type)

    product_ids = [product.id for product in filtered_products]

    # Возврат JSON-ответа
    return jsonify(product_ids), 200


@home_products_bp.route("/shop_get_pic/<int:product_id>", methods=["GET", "OPTIONS"])
@cross_origin()
def get_product_image(product_id):
    if request.method == "OPTIONS":
        return jsonify({"status": "ok"}), 200
    product = AllProduct.query.get(product_id)
    if product:
        # Путь до файла из базы данных
        image_path = f"..\\src\\assets\\images\\products\\{product.product_type}\\{product_id}.jpg"
        # Отправляем файл клиенту
        return send_file(image_path, mimetype="image/jpg")
    else:
        return "Product not found", 404


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


# @home_products_bp.route("/shop_filter_products", methods=["POST"])
# @cross_origin()
# def shop_filter_products():
#     data = request.get_json()
#     searchTerm = data.get("searchTerm", None)  # Handle optional search term
#     selectedProductTypes = data.get("selectedProductTypes", [])
#     selectedCategories = data.get("selectedCategories", [])

#     # Get all products
#     products = AllProduct.query.all()

#     # Filter by search term (optional)
#     if searchTerm:
#         products = [
#             product
#             for product in products
#             if searchTerm.lower() in product.name.lower()
#         ]

#     # Filter by product types
#     if selectedProductTypes:
#         products = [
#             product
#             for product in products
#             if product.product_type in selectedProductTypes
#         ]

#     # Filter by categories and subcategories
#     if selectedCategories:
#         filtered_products = []
#         for product in products:
#             # Check if the product belongs to any of the selected categories
#             for selectedCategory in selectedCategories:
#                 if product.category == selectedCategory:
#                     filtered_products.append(product)
#                     break  # Move on to the next product after a category match

#                 # Check subcategories within the selected category
#                 subcategory_data = table_models.get(product.category, {})
#                 if subcategory_data:
#                     for subcategory, model in subcategory_data.items():
#                         subcategory_values = [
#                             getattr(item, "id") for item in model.query.all()
#                         ]
#                         if product.id in subcategory_values:
#                             filtered_products.append(product)
#                             break  # Move on to the next product after a subcategory match
#         products = filtered_products

#     serialized_products = [product.serialize() for product in products]
#     return jsonify(serialized_products)

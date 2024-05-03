from flask import Flask, Blueprint, request, jsonify
from flask_cors import CORS, cross_origin
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


@home_products_bp.route("/shop_filter_products", methods=["POST"])
@cross_origin()
def shop_filter_products():
    data = request.get_json()
    searchTerm = data.get("searchTerm", None)  # Handle optional search term
    selectedProductTypes = data.get("selectedProductTypes", [])
    selectedCategories = data.get("selectedCategories", [])

    # Get all products
    products = AllProduct.query.all()

    # Filter by search term (optional)
    if searchTerm:
        products = [
            product
            for product in products
            if searchTerm.lower() in product.name.lower()
        ]

    # Filter by product types
    if selectedProductTypes:
        products = [
            product
            for product in products
            if product.product_type in selectedProductTypes
        ]

    # Filter by categories and subcategories
    if selectedCategories:
        filtered_products = []
        for product in products:
            # Check if the product belongs to any of the selected categories
            for selectedCategory in selectedCategories:
                if product.category == selectedCategory:
                    filtered_products.append(product)
                    break  # Move on to the next product after a category match

                # Check subcategories within the selected category
                subcategory_data = table_models.get(product.category, {})
                if subcategory_data:
                    for subcategory, model in subcategory_data.items():
                        subcategory_values = [
                            getattr(item, "id") for item in model.query.all()
                        ]
                        if product.id in subcategory_values:
                            filtered_products.append(product)
                            break  # Move on to the next product after a subcategory match
        products = filtered_products

    serialized_products = [product.serialize() for product in products]
    return jsonify(serialized_products)


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

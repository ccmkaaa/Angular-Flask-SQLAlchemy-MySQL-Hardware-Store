from flask_cors import CORS, cross_origin
from flask import Flask, request, jsonify, Blueprint, abort
import json
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
from alchemy.entities.cart import OrderCart
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func


stat_bp = Blueprint("stat", __name__)


@stat_bp.route("/total_quantity_amount", methods=["GET"])
@cross_origin()
def total_quantity_amount():
    all_products = AllProduct.query.all()
    total_quantity = sum(product.quantity for product in all_products)
    return jsonify({"total_quantity": total_quantity}), 200


@stat_bp.route("/total_orders_sales", methods=["GET"])
@cross_origin()
def total_orders_sales():
    total_orders = OrderCart.query.count()
    return jsonify({"total_orders": total_orders}), 200


@stat_bp.route("/total_sales_products", methods=["GET"])
@cross_origin()
def total_sales_products():
    orders = OrderCart.query.all()
    total_sales = 0

    for order in orders:
        cart_products = json.loads(order.cart_products)
        for item in cart_products:
            total_sales += item["quantity"]
    return jsonify({"total_sales": total_sales}), 200


@stat_bp.route("/total_sales_amount", methods=["GET"])
@cross_origin()
def total_sales_amount():
    orders = OrderCart.query.all()
    total_amount = sum(order.total_amount for order in orders)
    return jsonify({"total_amount": total_amount}), 200


@stat_bp.route("/total_quantity_remaining_by_product_type", methods=["GET"])
@cross_origin()
def total_quantity_remaining_by_product_type():
    total_remaining = (
        db_products.session.query(
            AllProduct.product_type, func.sum(AllProduct.quantity)
        )
        .group_by(AllProduct.product_type)
        .all()
    )
    total_remaining_dict = dict(total_remaining)
    return jsonify(total_remaining_dict), 200


@stat_bp.route("/total_amount_remaining_by_product_type", methods=["GET"])
@cross_origin()
def total_amount_remaining_by_product_type():
    total_remaining = (
        db_products.session.query(AllProduct.product_type, func.sum(AllProduct.price))
        .group_by(AllProduct.product_type)
        .all()
    )
    total_remaining_dict = dict(total_remaining)
    return jsonify(total_remaining_dict), 200

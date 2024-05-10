from flask_sqlalchemy import SQLAlchemy
from flask import Flask, Blueprint

from alchemy.model import db as db_cart


class OrderCart(db_cart.Model):
    __tablename__ = "order_cart"

    id = db_cart.Column(db_cart.Integer, primary_key=True)
    cart_products = db_cart.Column(db_cart.Text, nullable=False)
    id_acc = db_cart.Column(
        db_cart.Integer, db_cart.ForeignKey("account.id"), nullable=False
    )
    order_date = db_cart.Column(db_cart.DateTime, nullable=False)
    total_amount = db_cart.Column(db_cart.Integer, nullable=False)

    def serialize(self):
        return {
            "id": self.id,
            "cart_products": self.cart_products,
            "id_acc": self.id_acc,
            "order_date": self.order_date,
            "total_amount": self.total_amount,
        }

from flask_sqlalchemy import SQLAlchemy
from flask import Flask, Blueprint

from alchemy.model import db as db_users


class Account(db_users.Model):
    __tablename__ = "account"

    id = db_users.Column(db_users.Integer, primary_key=True, autoincrement=True)
    login = db_users.Column(db_users.Text, index=True, unique=True, nullable=False)
    password = db_users.Column(db_users.Text, nullable=False)

    def __repr__(self):
        return f"<Account {self.login}>"


class AccountAdmin(db_users.Model):
    __tablename__ = "account_admin"

    id = db_users.Column(db_users.Integer, primary_key=True, autoincrement=True)
    isadmin = db_users.Column(db_users.Integer, default=0)

    def __repr__(self):
        return f"<AccountAdmin {self.id}>"

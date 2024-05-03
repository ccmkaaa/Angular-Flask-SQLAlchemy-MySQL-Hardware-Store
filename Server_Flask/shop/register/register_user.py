from flask import Flask, Blueprint, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import check_password_hash

from alchemy.entities.users import db_users as db, AccountAdmin, Account

reg_bp = Blueprint("reg", __name__)

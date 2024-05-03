from flask_sqlalchemy import SQLAlchemy
from flask import Flask

# from alchemy.entities.users import db_users

# from alchemy.entities.products import (
#     db_products as db_products,
#     AllProduct,
#     GPU,
#     GpuBrand,
#     GpuCoolers,
#     GpuDistributor,
#     GpuMemorySize,
#     CPU,
#     CpuBrand,
#     CpuCores,
#     RAM,
#     RamBrand,
#     RamCapacity,
#     RamFrequency,
#     RamMemoryType,
#     MB,
#     MbFormat,
#     MbSocket,
#     MbWiFi,
# )

db = SQLAlchemy()


def create_app():
    app = Flask(__name__)
    app.config[
        "SQLALCHEMY_DATABASE_URI"
    ] = "mysql+mysqlconnector://root:@localhost/angular_app"
    # Строка подключения имеет формат: 'mysql+mysqlconnector://<username>:<password>@<host>/<database_name>'
    # подходящий драйвер, такой как mysql-connector-python?
    db.init_app(app)

    return app

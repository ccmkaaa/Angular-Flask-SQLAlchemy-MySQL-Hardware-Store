from flask_sqlalchemy import SQLAlchemy
from flask import Flask

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


class AllProduct(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.Text, nullable=True)
    pic = db.Column(db.Text, nullable=True)
    product_type = db.Column(db.Text, nullable=False)
    quantity = db.Column(db.Integer, nullable=False, default=1)
    price = db.Column(db.Integer, nullable=False, default=0)

    def __repr__(self):
        return f"<AllProduct {self.name}>"

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "pic": self.pic,
            "product_type": self.product_type,
            "quantity": self.quantity,
            "price": self.price,
        }


class GPU(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.Text, nullable=False)
    brand = db.Column(db.Text, nullable=True)
    distributor = db.Column(db.Text, nullable=True)
    memory_size = db.Column(db.Integer, nullable=True)
    coolers = db.Column(db.Integer, nullable=True)
    id_brand = db.Column(db.Integer, db.ForeignKey("gpu_brand.id"), nullable=False)
    id_distributor = db.Column(
        db.Integer, db.ForeignKey("gpu_distributor.id"), nullable=False
    )
    id_memory_size = db.Column(
        db.Integer, db.ForeignKey("gpu_memory_size.id"), nullable=False
    )
    id_coolers = db.Column(db.Integer, db.ForeignKey("gpu_coolers.id"), nullable=False)

    def __repr__(self):
        return f"<GPU {self.name}>"

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "brand": self.brand,
            "distributor": self.distributor,
            "memory_size": self.memory_size,
            "coolers": self.coolers,
            "id_brand": self.id_brand,
            "id_distributor": self.id_distributor,
            "id_memory_size": self.id_memory_size,
            "id_coolers": self.id_coolers,
        }


class CPU(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.Text, nullable=False)
    brand = db.Column(db.Text, nullable=True)
    cores = db.Column(db.Integer, nullable=True)
    id_brand = db.Column(db.Integer, db.ForeignKey("cpu_brand.id"), nullable=False)
    id_cores = db.Column(db.Integer, db.ForeignKey("cpu_cores.id"), nullable=False)

    def __repr__(self):
        return f"<CPU {self.name}>"

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "brand": self.brand,
            "cores": self.cores,
            "id_brand": self.id_brand,
            "id_cores": self.id_cores,
        }


class RAM(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.Text, nullable=False)
    brand = db.Column(db.Text, nullable=True)
    memory_type = db.Column(db.Text, nullable=True)
    capacity = db.Column(db.Integer, nullable=True)
    frequency = db.Column(db.Integer, nullable=True)
    id_brand = db.Column(db.Integer, db.ForeignKey("ram_product.id"), nullable=False)
    id_memory_type = db.Column(
        db.Integer, db.ForeignKey("ram_product.id"), nullable=False
    )
    id_capacity = db.Column(
        db.Integer, db.ForeignKey("ram_capacity.id"), nullable=False
    )
    id_frequency = db.Column(
        db.Integer, db.ForeignKey("ram_frequency.id"), nullable=False
    )

    def __repr__(self):
        return f"<RAM {self.name}>"

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "brand": self.brand,
            "memory_type": self.memory_type,
            "capacity": self.capacity,
            "frequency": self.frequency,
            "id_brand": self.id_brand,
            "id_memory_type": self.id_memory_type,
            "id_capacity": self.id_capacity,
            "id_frequency": self.id_frequency,
        }


class MB(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.Text, nullable=False)
    format = db.Column(db.Text, nullable=True)
    socket = db.Column(db.Text, nullable=True)
    wi_fi = db.Column(db.Text, nullable=True)
    id_format = db.Column(db.Integer, db.ForeignKey("mb_format.id"), nullable=False)
    id_socket = db.Column(db.Integer, db.ForeignKey("mb_socket.id"), nullable=False)
    id_wi_fi = db.Column(db.Integer, db.ForeignKey("mb_wi_fi.id"), nullable=False)

    def __repr__(self):
        return f"<MB {self.name}>"

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "format": self.format,
            "socket": self.socket,
            "wi_fi": self.wi_fi,
            "id_format": self.id_format,
            "id_socket": self.id_socket,
            "id_wi_fi": self.id_wi_fi,
        }


class GpuBrand(db.Model):
    __tablename__ = "gpu_brand"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    brand = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<GPUBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class GpuCoolers(db.Model):
    __tablename__ = "gpu_coolers"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    coolers = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"<GPUCoolers {self.coolers}>"

    def serialize(self):
        return {
            "id": self.id,
            "coolers": self.coolers,
        }


class GpuDistributor(db.Model):
    __tablename__ = "gpu_distributor"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    distributor = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<GPUDistributor {self.distributor}>"

    def serialize(self):
        return {
            "id": self.id,
            "distributor": self.distributor,
        }


class GpuMemorySize(db.Model):
    __tablename__ = "gpu_memory_size"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    memory_size = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"<GPUMemorySize {self.memory_size}>"

    def serialize(self):
        return {
            "id": self.id,
            "memory_size": self.memory_size,
        }


class CpuBrand(db.Model):
    __tablename__ = "cpu_brand"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    brand = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<CpuBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class CpuCores(db.Model):
    __tablename__ = "cpu_cores"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    cores = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"<CpuCores {self.cores}>"

    def serialize(self):
        return {
            "id": self.id,
            "cores": self.cores,
        }


class MbFormat(db.Model):
    __tablename__ = "mb_format"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    format = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<MbFormat {self.format}>"

    def serialize(self):
        return {
            "id": self.id,
            "format": self.format,
        }


class MbSocket(db.Model):
    __tablename__ = "mb_socket"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    socket = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<MbSocket {self.socket}>"

    def serialize(self):
        return {
            "id": self.id,
            "socket": self.socket,
        }


class MbWiFi(db.Model):
    __tablename__ = "mb_wi_fi"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    wi_fi = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<MbWiFi {self.wi_fi}>"

    def serialize(self):
        return {
            "id": self.id,
            "wi_fi": self.wi_fi,
        }


class RamBrand(db.Model):
    __tablename__ = "ram_brand"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    brand = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<RamBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class RamCapacity(db.Model):
    __tablename__ = "ram_capacity"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    capacity = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"<RamCapacity {self.capacity}>"

    def serialize(self):
        return {
            "id": self.id,
            "capacity": self.capacity,
        }


class RamFrequency(db.Model):
    __tablename__ = "ram_frequency"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    frequency = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return f"<RamFrequency {self.frequency}>"

    def serialize(self):
        return {
            "id": self.id,
            "frequency": self.frequency,
        }


class RamMemoryType(db.Model):
    __tablename__ = "ram_memory_type"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    memory_type = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f"<RamMemoryType {self.memory_type}>"

    def serialize(self):
        return {
            "id": self.id,
            "memory_type": self.memory_type,
        }

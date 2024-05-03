from flask_sqlalchemy import SQLAlchemy
from flask import Flask, Blueprint

from alchemy.model import db as db_products


class AllProduct(db_products.Model):
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    name = db_products.Column(db_products.Text, nullable=True)
    pic = db_products.Column(db_products.Text, nullable=True)
    product_type = db_products.Column(db_products.Text, nullable=False)
    quantity = db_products.Column(db_products.Integer, nullable=False, default=1)
    price = db_products.Column(db_products.Integer, nullable=False, default=0)
    description = db_products.Column(db_products.Text, nullable=True)

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
            "description": self.description,
        }


class GPU(db_products.Model):
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    name = db_products.Column(db_products.Text, nullable=False)
    brand = db_products.Column(db_products.Text, nullable=True)
    distributor = db_products.Column(db_products.Text, nullable=True)
    memory_size = db_products.Column(db_products.Integer, nullable=True)
    coolers = db_products.Column(db_products.Integer, nullable=True)
    id_brand = db_products.Column(
        db_products.Integer, db_products.ForeignKey("gpu_brand.id"), nullable=False
    )
    id_distributor = db_products.Column(
        db_products.Integer,
        db_products.ForeignKey("gpu_distributor.id"),
        nullable=False,
    )
    id_memory_size = db_products.Column(
        db_products.Integer,
        db_products.ForeignKey("gpu_memory_size.id"),
        nullable=False,
    )
    id_coolers = db_products.Column(
        db_products.Integer, db_products.ForeignKey("gpu_coolers.id"), nullable=False
    )

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


class CPU(db_products.Model):
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    name = db_products.Column(db_products.Text, nullable=False)
    brand = db_products.Column(db_products.Text, nullable=True)
    cores = db_products.Column(db_products.Integer, nullable=True)
    id_brand = db_products.Column(
        db_products.Integer, db_products.ForeignKey("cpu_brand.id"), nullable=False
    )
    id_cores = db_products.Column(
        db_products.Integer, db_products.ForeignKey("cpu_cores.id"), nullable=False
    )

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


class RAM(db_products.Model):
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    name = db_products.Column(db_products.Text, nullable=False)
    brand = db_products.Column(db_products.Text, nullable=True)
    memory_type = db_products.Column(db_products.Text, nullable=True)
    capacity = db_products.Column(db_products.Integer, nullable=True)
    frequency = db_products.Column(db_products.Integer, nullable=True)
    id_brand = db_products.Column(
        db_products.Integer, db_products.ForeignKey("ram_product.id"), nullable=False
    )
    id_memory_type = db_products.Column(
        db_products.Integer, db_products.ForeignKey("ram_product.id"), nullable=False
    )
    id_capacity = db_products.Column(
        db_products.Integer, db_products.ForeignKey("ram_capacity.id"), nullable=False
    )
    id_frequency = db_products.Column(
        db_products.Integer, db_products.ForeignKey("ram_frequency.id"), nullable=False
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


class MB(db_products.Model):
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    name = db_products.Column(db_products.Text, nullable=False)
    format = db_products.Column(db_products.Text, nullable=True)
    socket = db_products.Column(db_products.Text, nullable=True)
    wi_fi = db_products.Column(db_products.Text, nullable=True)
    id_format = db_products.Column(
        db_products.Integer, db_products.ForeignKey("mb_format.id"), nullable=False
    )
    id_socket = db_products.Column(
        db_products.Integer, db_products.ForeignKey("mb_socket.id"), nullable=False
    )
    id_wi_fi = db_products.Column(
        db_products.Integer, db_products.ForeignKey("mb_wi_fi.id"), nullable=False
    )

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


class GpuBrand(db_products.Model):
    __tablename__ = "gpu_brand"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    brand = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<GPUBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class GpuCoolers(db_products.Model):
    __tablename__ = "gpu_coolers"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    coolers = db_products.Column(db_products.Integer, nullable=False)

    def __repr__(self):
        return f"<GPUCoolers {self.coolers}>"

    def serialize(self):
        return {
            "id": self.id,
            "coolers": self.coolers,
        }


class GpuDistributor(db_products.Model):
    __tablename__ = "gpu_distributor"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    distributor = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<GPUDistributor {self.distributor}>"

    def serialize(self):
        return {
            "id": self.id,
            "distributor": self.distributor,
        }


class GpuMemorySize(db_products.Model):
    __tablename__ = "gpu_memory_size"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    memory_size = db_products.Column(db_products.Integer, nullable=False)

    def __repr__(self):
        return f"<GPUMemorySize {self.memory_size}>"

    def serialize(self):
        return {
            "id": self.id,
            "memory_size": self.memory_size,
        }


class CpuBrand(db_products.Model):
    __tablename__ = "cpu_brand"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    brand = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<CpuBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class CpuCores(db_products.Model):
    __tablename__ = "cpu_cores"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    cores = db_products.Column(db_products.Integer, nullable=False)

    def __repr__(self):
        return f"<CpuCores {self.cores}>"

    def serialize(self):
        return {
            "id": self.id,
            "cores": self.cores,
        }


class MbFormat(db_products.Model):
    __tablename__ = "mb_format"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    format = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<MbFormat {self.format}>"

    def serialize(self):
        return {
            "id": self.id,
            "format": self.format,
        }


class MbSocket(db_products.Model):
    __tablename__ = "mb_socket"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    socket = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<MbSocket {self.socket}>"

    def serialize(self):
        return {
            "id": self.id,
            "socket": self.socket,
        }


class MbWiFi(db_products.Model):
    __tablename__ = "mb_wi_fi"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    wi_fi = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<MbWiFi {self.wi_fi}>"

    def serialize(self):
        return {
            "id": self.id,
            "wi_fi": self.wi_fi,
        }


class RamBrand(db_products.Model):
    __tablename__ = "ram_brand"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    brand = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<RamBrand {self.brand}>"

    def serialize(self):
        return {
            "id": self.id,
            "brand": self.brand,
        }


class RamCapacity(db_products.Model):
    __tablename__ = "ram_capacity"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    capacity = db_products.Column(db_products.Integer, nullable=False)

    def __repr__(self):
        return f"<RamCapacity {self.capacity}>"

    def serialize(self):
        return {
            "id": self.id,
            "capacity": self.capacity,
        }


class RamFrequency(db_products.Model):
    __tablename__ = "ram_frequency"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    frequency = db_products.Column(db_products.Integer, nullable=False)

    def __repr__(self):
        return f"<RamFrequency {self.frequency}>"

    def serialize(self):
        return {
            "id": self.id,
            "frequency": self.frequency,
        }


class RamMemoryType(db_products.Model):
    __tablename__ = "ram_memory_type"
    id = db_products.Column(db_products.Integer, primary_key=True, autoincrement=True)
    memory_type = db_products.Column(db_products.Text, nullable=False)

    def __repr__(self):
        return f"<RamMemoryType {self.memory_type}>"

    def serialize(self):
        return {
            "id": self.id,
            "memory_type": self.memory_type,
        }

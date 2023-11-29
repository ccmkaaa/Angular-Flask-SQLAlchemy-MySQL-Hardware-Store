import mysql.connector

db = mysql.connector.connect(
    host="127.0.0.1",  # IP-адрес сервера MySQL
    port=3306,
    user="root",
    password="",
    database="angular_app",  # Имя базы данных MySQL
)

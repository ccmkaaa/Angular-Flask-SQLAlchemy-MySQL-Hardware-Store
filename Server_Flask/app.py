from flask import Flask, request, jsonify
import json
from flask_cors import CORS, cross_origin

app = Flask(__name__)
CORS(app)

# Функция для чтения данных из JSON-файла
def read_products():
    try:
        with open('../src/assets/products.json', 'r') as json_file:
            products = json.load(json_file)
    except FileNotFoundError:
        products = []
    return products

@app.route("/add_product", methods=["POST"])
@cross_origin()
def add_product():
    data = request.get_json()
    products = read_products()
    print(products)
    products.append(data)

    # Записываем обновленные данные в JSON-файл
    with open('../src/assets/products.json', 'w') as json_file:
        json.dump(products, json_file)

    return jsonify({'message': 'Товар успешно добавлен', 'data': data})

if __name__ == "__main__":
    app.run(port=5000)

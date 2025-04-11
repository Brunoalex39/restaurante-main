from flask import Flask, request, jsonify

app = Flask(__name__)

# Banco de dados em memória
pedidos = []

@app.route('/pedido', methods=['POST'])
def criar_pedido():
    data = request.get_json()
    pedidos.append(data)
    return jsonify({"mensagem": "Pedido criado com sucesso!", "pedido": data}), 201

@app.route('/pedidos', methods=['GET'])
def listar_pedidos():
    return jsonify(pedidos)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

    # C:\Users\Samsung\Downloads\restaurante-main\restaurante-main\app.py

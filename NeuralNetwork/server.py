from flask import Flask, send_from_directory, request, jsonify
from nn import predict
app = Flask(__name__)


@app.route('/<path>')
def serve_static(path):
    return send_from_directory('static', path)


@app.route('/recognize', methods=['POST'])
def add_message():
    content = request.json
    res, prob = predict(content["image"]);
    return jsonify({"res": res.item(), "probabilities": prob.tolist()})

app.run(port=3000)

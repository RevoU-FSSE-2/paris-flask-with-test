from flask import Blueprint, jsonify

home_router = Blueprint("home", __name__)


@home_router.route("/", methods=["GET"])
def home():
    return jsonify({"message":"Hello, World!"}), 200

from flask import Blueprint, jsonify, request

user_router = Blueprint("user", __name__)


@user_router.route("/user", methods=["POST"])
def create_user():
    email = request.json["email"]

    return jsonify({"message": f"User {email} created successfully"}), 201


@user_router.route("/user", methods=["GET"])
def list_users():
    return jsonify({"message": "List of users"}), 200

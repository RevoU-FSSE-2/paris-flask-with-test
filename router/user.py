from flask import Blueprint, jsonify, request

user_router = Blueprint("user", __name__)


@user_router.route("/user", methods=["POST"])
def create_user():
    email = request.json["email"]

    return jsonify({"message": f"User {email} created successfully"}), 201

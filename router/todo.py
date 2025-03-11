from flask import Blueprint, jsonify, request

from service.todo_service import get_todo_by_id, get_todos

todo_bp = Blueprint("todo", __name__, url_prefix="/todos")

@todo_bp.route("", methods=["GET"])
def list_todos():
    limit = request.args.get("limit", 5, type=int)
    todos = get_todos(limit=limit)
    return jsonify(todos)

@todo_bp.route("/<int:todo_id>", methods=["GET"])
def get_todo(todo_id):
    todo = get_todo_by_id(todo_id)
    return jsonify(todo)

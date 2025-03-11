from flask import Flask, request

from router.home import home_router
from router.todo import todo_bp
from router.user import user_router


def create_app(config_object="config.local"):
    app = Flask(__name__)
    app.config.from_object(config_object)

    app.register_blueprint(home_router)
    app.register_blueprint(user_router)
    app.register_blueprint(todo_bp)

    return app

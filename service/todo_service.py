import requests


def get_todos(limit=5):
    """
    Get todos from DummyJSON API
    """
    print("AKUUUU DIPANGGGIIILLL TIDAAAK")
    response = requests.get(f"https://dummyjson.com/todos?limit={limit}")
    return response.json()


def get_todo_by_id(todo_id):
    """
    Get a specific todo by ID
    """
    response = requests.get(f"https://dummyjson.com/todos/{todo_id}")
    return response.json()

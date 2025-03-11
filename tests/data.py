MOCK_TODOS_RESPONSE = {
    "todos": [
        {
            "id": 1,
            "todo": "Do something nice for someone I care about",
            "completed": True,
            "userId": 26,
        },
        {
            "id": 2,
            "todo": "Memorize the fifty states and their capitals",
            "completed": False,
            "userId": 48,
        },
    ],
    "total": 2,
    "skip": 0,
    "limit": 2,
}

# Mock response for get_todo_by_id
MOCK_TODO_RESPONSE = {
    "id": 1,
    "todo": "Do something nice for someone I care about",
    "completed": True,
    "userId": 26,
}
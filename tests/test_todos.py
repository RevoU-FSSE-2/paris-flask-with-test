from tests.data import MOCK_TODO_RESPONSE, MOCK_TODOS_RESPONSE


def test_list_todos(client, mocker):
    mocker.patch("service.todo_service.get_todos", return_value=MOCK_TODOS_RESPONSE)
    from service.todo_service import get_todos
    assert get_todos() == MOCK_TODOS_RESPONSE


def test_list_todo_endpoint(client, mocker):
    mocker.patch("router.todo.get_todos", return_value=MOCK_TODOS_RESPONSE)
    response = client.get("/todos")
    assert response.status_code == 200
    assert response.json == MOCK_TODOS_RESPONSE


def test_detail_todo_endpoint(client, mocker):
    mocker.patch("router.todo.get_todo_by_id", return_value=MOCK_TODO_RESPONSE)
    response = client.get("/todos/1")
    assert response.status_code == 200
    assert response.json == MOCK_TODO_RESPONSE

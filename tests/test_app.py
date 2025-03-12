def test_index_home(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.json == {"message": "Hello, World!"}


def test_create_user(client):
    response = client.post("/user", json={"email": "budi@gmail.com"})
    assert response.status_code == 201
    assert response.json == {"message": "User budi@gmail.com created successfully"}


def test_list_users(client):
    response = client.get("/user")
    assert response.status_code == 200
    assert response.json == {
        "message": [
            {"email": "iwan@gmail.com", "id": 1},
        ]
    }

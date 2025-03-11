def test_index_home(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.json == {"message": "Hello, World!"}


def test_create_user(client):
    response = client.post("/user", json={"email": "budi@gmail.com"})
    assert response.status_code == 201
    assert response.json == {"message": "User budi@gmail.com created successfully"}
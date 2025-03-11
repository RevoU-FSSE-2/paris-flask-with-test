import pytest

from config.settings import create_app


@pytest.fixture
def test_app(
):  # Add dependency on mock_fixture to ensure it's applied first
    app = create_app("config.testing")
    yield app


@pytest.fixture
def client(test_app):
    return test_app.test_client()

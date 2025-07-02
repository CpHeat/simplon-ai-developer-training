from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_get_products():
    resp = client.get("/products")
    assert resp.status_code == 200
    assert resp.json() == {"products": ["apple", "banana", "orange"]}
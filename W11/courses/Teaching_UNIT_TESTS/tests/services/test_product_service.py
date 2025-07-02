from app.services.product_service import ProductService

product_service = ProductService()

class TestProductService:
    def test_get_all_products(self):
        result = product_service.get_all_products()
        excepted = ["apple", "banana", "orange"]
        assert result == excepted
    
    def test_delete_product(self):
        assert True

    def test_change_price_product(self):
        assert True
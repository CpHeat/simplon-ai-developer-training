from ..models.product import Product
import asyncio

class ProductService:
    def get_all_products(self):
        return ["apple", "banana", "orange"]
    
    async def get_product_by_id(self, id: str):
        # Simulation du délais de chargementdes données
        # depuis la BDD
        await asyncio.sleep(6)
        return Product(id=id, name="iPhone", price=699.0)
    
    def delete_product(self, id: str):
        pass

    def change_price_product(self, new_price: float):
        pass
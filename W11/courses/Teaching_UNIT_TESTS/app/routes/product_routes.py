from fastapi import APIRouter
from ..services.product_service import ProductService
from ..models.input_product_update_price import InputProductUpdatePrice
from ..models.output_product import OutputProduct

router = APIRouter(
    prefix="/products"
)

product_service = ProductService()

@router.get("/")
async def all_products():
    products = product_service.get_all_products()
    return {
        "products": products
    }

@router.get("/{product_id}", response_model=OutputProduct)
async def product(product_id: str):
    product = await product_service.get_product_by_id(id=product_id)
    return product

@router.put("/")
async def product(product_update_price: InputProductUpdatePrice):
    return product_update_price
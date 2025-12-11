from fastapi import FastAPI
from .routes.product_routes import router as products_router

app = FastAPI()

app.include_router(router=products_router)
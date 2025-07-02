from pydantic import BaseModel

class OutputProduct(BaseModel):
    name: str
    price: float
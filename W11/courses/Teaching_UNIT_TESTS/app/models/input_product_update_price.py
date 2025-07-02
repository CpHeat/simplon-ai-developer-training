from pydantic import BaseModel

class InputProductUpdatePrice(BaseModel):
    id: str
    price: float
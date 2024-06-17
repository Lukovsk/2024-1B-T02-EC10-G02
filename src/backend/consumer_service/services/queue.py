from pydantic import BaseModel
from typing import Optional


class CreateOrder(BaseModel):
    problem: str
    pyxisId: str
    senderId: str

    description: Optional[str]
    itemId: Optional[str]


class Payload(BaseModel):
    order_status: str
    data: CreateOrder

from pydantic import BaseModel
from typing import Optional
from enum import Enum


class Command(str, Enum):
    create = "create"
    accept = "accept"
    reject = "reject"
    done = "done"
    cancel = "cancel"


class Problem(str, Enum):
    stock = "stock"
    technical = "technical"


class CreateOrder(BaseModel):
    sender_userId: str
    pyxiId: str
    problem: Problem
    description: Optional[str] = None
    itemId: Optional[str] = None


class AcceptOrder(BaseModel):
    receiver_userId: str
    order_id: str


class DoneOrder(BaseModel):
    order_id: str


class CancelOrder(BaseModel):
    order_id: str
    canceled_reason: str
    canceled_userId: str


class RejectOrder(BaseModel):
    order_id: str

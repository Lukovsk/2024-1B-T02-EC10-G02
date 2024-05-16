from pydantic import BaseModel
from typing import Optional


class CreateOrder(BaseModel):
    medicationId: str
    senderId: str
    status: str


class UpdateOrder(BaseModel):
    id: str
    medicationId: Optional[str] = None
    senderId: Optional[str] = None
    receiverId: Optional[str] = None
    feedbackId: Optional[str] = None
    canceled_reason: Optional[str] = None
    canceled_userId: Optional[str] = None


class CancelateOrder(BaseModel):
    id: str
    reason: str
    userId: str

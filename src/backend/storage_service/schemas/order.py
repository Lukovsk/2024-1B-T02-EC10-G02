from pydantic import BaseModel
from typing import Optional, List
from prisma.enums import Status, Problem


class CreateOrder(BaseModel):
    pyxiId: str
    senderId: str
    description: Optional[str] = None
    itemId: Optional[str] = None
    # status: Optional[List[Status]] = None


class UpdateOrder(BaseModel):
    id: str
    medicationId: Optional[str] = None
    sender_userId: Optional[str] = None
    receiver_userId: Optional[str] = None
    feedbackId: Optional[str] = None
    canceled_reason: Optional[str] = None
    canceled_userId: Optional[str] = None
    status: Optional[Status] = None


class CancelateOrder(BaseModel):
    reason: str
    userId: str

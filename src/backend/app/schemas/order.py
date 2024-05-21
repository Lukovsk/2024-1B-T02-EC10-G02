from pydantic import BaseModel
from typing import Optional, List
from enum import Enum


class CreateOrder(BaseModel):
    medicationId: str
    senderId: str
    status: str

class StatusEnum(str, Enum):
    PENDING = "PENDING"
    ACCEPTED = "ACCEPTED"
    REJECTED = "REJECTED"
    DONE = "DONE"
    CANCELED = "CANCELED"

class UpdateOrder(BaseModel):
    id: str
    medicationId: Optional[str] = None
    senderId: Optional[str] = None
    receiverId: Optional[str] = None
    feedbackId: Optional[str] = None
    canceled_reason: Optional[str] = None
    canceled_userId: Optional[str] = None
    status: Optional[List[StatusEnum]] = None
    


class CancelateOrder(BaseModel):
    id: str
    reason: str
    userId: str

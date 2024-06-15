from pydantic import BaseModel
from typing import Optional, List
from enum import Enum

class Status(str, Enum):
    PENDING = "PENDING"
    REJECTED = "REJECTED"
    DONE = "DONE"
    CANCELED = "CANCELED"

class CreateOrder(BaseModel):
    medicationId: Optional[str] = None
    sender_userId: str 
    # status: Optional[List[Status]] = None



class UpdateOrder(BaseModel):
    id: str
    medicationId: Optional[str] = None
    sender_userId: Optional[str] = None
    receiver_userId: Optional[str] = None
    feedbackId: Optional[str] = None
    canceled_reason: Optional[str] = None
    canceled_userId: Optional[str] = None
    status: Optional[List[Status]] = None 


    


class CancelateOrder(BaseModel):
    id: str
    reason: str
    userId: str

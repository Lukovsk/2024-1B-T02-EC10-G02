
from datetime import datetime
from schemas.order import Status
class OrderService:
    def __init__(
        self,
        id=None,
        medicationId=None,
        status=None,
        sender_userId=None,
        receiver_userId=None,
        feedbackId=None,
        createdAt=None,
        canceledAt=None,
        canceledBy=None,
        canceled_reason=None,
    ):
        self.id = id
        self.medicationId = medicationId
        self.status = status
        self.sender_userId = sender_userId
        self.receiver_userId = receiver_userId
        self.feedbackId = feedbackId
        self.createdAt = createdAt
        self.canceledAt = canceledAt
        self.canceledBy = canceledBy
        self.canceled_reason = canceled_reason
    async def get_closed_orders():
        pass

    async def get_all():
        pass 

    async def get_all_by_status(status: str):
        pass

    async def get_canceled_orders():
        pass  

    async def war():
        pass


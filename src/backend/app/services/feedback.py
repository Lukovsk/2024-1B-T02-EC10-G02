import asyncio
from prisma import Prisma
from prisma.models import Feedback, Request

class FeedbackService():
    @staticmethod
    async def create_feedback(rate_user: int, Request: list[Request], sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None) -> Feedback:
        db = Prisma(auto_register=True)
        await db.connect()
        feedback = await Feedback.prisma().create(
            data={
                'rate_user': rate_user,
                'Request': Request,
                'sender_userId': sender_userId,
                'receiver_userId': receiver_userId,
                'message_user': message_user,
                'message_app': message_app,
                'rate_app': rate_app
                }
        )
        await db.disconnect()
        return feedback
    
    async def get_all_feedbacks() -> list[Feedback]:
        db = Prisma(auto_register=True)
        await db.connect()
        feedbacks = await Feedback.prisma().find_many()
        await db.disconnect()
        return feedbacks
    
    async def get_feedback_by_id(id: int) -> Feedback:
        db = Prisma(auto_register=True)
        await db.connect()
        feedback = await Feedback.prisma().find_unique(where={'id': id})
        await db.disconnect()
        return feedback
    
    async def update_feedback(id: int, rate_user: int, Request: list[Request], sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None) -> Feedback:
        db = Prisma(auto_register=True)
        await db.connect()
        feedback = await Feedback.prisma().update(
            where={'id': id},
            data={
                'rate_user': rate_user,
                'Request': Request,
                'sender_userId': sender_userId,
                'receiver_userId': receiver_userId,
                'message_user': message_user,
                'message_app': message_app,
                'rate_app': rate_app
                }
        )
        await db.disconnect()
        return feedback
    
    async def delete_feedback(id: int) -> Feedback:
        db = Prisma(auto_register=True)
        await db.connect()
        feedback = await Feedback.prisma().delete(where={'id': id})
        await db.disconnect()
        return feedback
import asyncio
from prisma import Prisma
from prisma.models import Feedback, Request
from backend.storage.prismaClient import prismaClient

class FeedbackService():
    @staticmethod
    async def create_feedback(rate_user: int, Request: list, sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None) -> Feedback:
        data = {
            'rate_user': rate_user,
            'Request': Request,
            'sender_userId': sender_userId,
            'receiver_userId': receiver_userId,
            'message_user': message_user,
            'message_app': message_app,
            'rate_app': rate_app
        }

        # Remove any key-value pairs where the value is None
        filtered_data = {k: v for k, v in data.items() if v is not None}

        feedback = await prismaClient.feedback.create(
            data=filtered_data
        )
        return feedback

    
    async def get_all_feedbacks() -> list[Feedback]:
        feedbacks = await prismaClient.feedback.find_many()
        return feedbacks
    
    async def get_feedback_by_id(id: int) -> Feedback:
        feedback = await prismaClient.feedback.find_unique(where={'id': id})
        return feedback
    
    async def update_feedback(id: int, rate_user: int, Request: list[Request], sender_userId: int, receiver_userId: int, message_user: str=None, message_app: str=None, rate_app: int=None) -> Feedback:
        feedback = await prismaClient.feedback.update(
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
        return feedback
    
    async def delete_feedback(id: int) -> Feedback:
        feedback = await prismaClient.feedback.delete(where={'id': id})
        return feedback
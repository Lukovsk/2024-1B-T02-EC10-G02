from fastapi import Depends, APIRouter
from prisma.models import Feedback, Request
from backend.storage.services.feedback import FeedbackService

feedback_routes = APIRouter()


@feedback_routes.post("/feedback/", response_model=None)
async def create_feedback(feedback: Feedback):
    return await FeedbackService.create_feedback(
        feedback.rate_user,
        feedback.Request,
        feedback.sender_userId,
        feedback.receiver_userId,
        feedback.message_user,
        feedback.message_app,
        feedback.rate_app,
    )


@feedback_routes.get("/feedback/", response_model=list[Feedback])
async def get_all_feedbacks():
    return await FeedbackService.get_all_feedbacks()


@feedback_routes.get("/feedback/{id}", response_model=Feedback)
async def get_feedback_by_id(id: int):
    return await FeedbackService.get_feedback_by_id(id)


@feedback_routes.put("/feedback/{id}", response_model=Feedback)
async def update_feedback(id: int, feedback: Feedback):
    return await FeedbackService.update_feedback(
        id,
        feedback.rate_user,
        feedback.Request,
        feedback.sender_userId,
        feedback.receiver_userId,
        feedback.message_user,
        feedback.message_app,
        feedback.rate_app,
    )


@feedback_routes.delete("/feedback/{id}", response_model=Feedback)
async def delete_feedback(id: int):
    return await FeedbackService.delete_feedback(id)

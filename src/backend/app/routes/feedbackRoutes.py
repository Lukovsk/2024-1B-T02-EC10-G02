from fastapi import Depends, APIRouter
from prisma.models import Feedback, Request
from services.feedback import FeedbackService

feedback_routes = APIRouter()

@feedback_routes.post("/feedback/", response_model=None)
async def create_feedback(feedback: Feedback):
    return FeedbackService.create_feedback(**feedback)

# @feedback_routes.get("/feedback{feedback_id}", response_model=None)
# def get_feedback(user_id: int, db: Session = Depends(get_db)):
#     return UserController.get_user_by_id(db, user_id)

# @feedback_routes.put("/feedback/{feedback_id}", response_model=None)
# def update_feedback(user_id: int, updated_user: User, db: Session = Depends(get_db)):
#     return UserController.update_user(db, user_id, updated_user)

# @feedback_routes.delete("/feedback/{feedback_id}")
# def delete_feedback(user_id: int, db: Session = Depends(get_db)):
#     return UserController.delete_user(db, user_id)

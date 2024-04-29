from fastapi import Depends, APIRouter
from sqlalchemy.orm import Session
from ..model.model import User
from ..controller.userController import UserController
from ..main import get_db

user_routes = APIRouter()

@user_routes.post("/user/", response_model=None)
async def create_user(medication: User, db: Session = Depends(get_db)):
    return UserController.create_user(db, medication)

@user_routes.get("/user/{user_id}", response_model=None)
def read_medication(user_id: int, db: Session = Depends(get_db)):
    return UserController.get_user_by_id(db, user_id)

@user_routes.put("/user/{user_id}", response_model=None)
def update_medication(user_id: int, updated_user: User, db: Session = Depends(get_db)):
    return UserController.update_user(db, user_id, updated_user)

@user_routes.delete("/user/{user_id}")
def delete_medication(user_id: int, db: Session = Depends(get_db)):
    return UserController.delete_user(db, user_id)

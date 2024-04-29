from fastapi import HTTPException
from ..model.model import UserBase
from sqlalchemy.orm import Session

class UserController:
    @staticmethod
    def create_user(db: Session, user: UserBase):
        db_user = UserBase(**user.dict())
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

    @staticmethod
    def get_user_by_id(db: Session, user_id: int):
        user = db.query(UserBase).filter(UserBase.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        return user

    @staticmethod
    def update_user(db: Session, user_id: int, updated_user: UserBase):
        user = UserController.get_user_by_id(db, user_id)
        for key, value in updated_user.dict().items():
            setattr(user, key, value)
        db.commit()
        db.refresh(user)
        return user

    @staticmethod
    def delete_user(db: Session, user_id: int):
        user = UserController.get_medication_by_id(db, user_id)
        db.delete(user)
        db.commit()
        return {"message": "User deleted successfully"}

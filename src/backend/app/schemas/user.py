from pydantic import BaseModel
from typing import Optional

class UpdateUserRequest(BaseModel):
    email: Optional[str] = None
    name: Optional[str] = None

class CreateUserRequest(BaseModel):
    email: str
    name: str
    password: str

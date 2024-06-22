from pydantic import BaseModel
from typing import Optional
from prisma.enums import Role


class UpdateUserRequest(BaseModel):
    email: Optional[str] = None
    name: Optional[str] = None
    


class CreateUserRequest(BaseModel):
    email: str
    name: str
    password: str
    role: Optional[Role] = None


class LoginUserRequest(BaseModel):
    email: str
    password: str


class AuxUpdate(BaseModel):
    disponibility: bool

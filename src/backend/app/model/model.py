from pydantic import BaseModel
from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Medication(BaseModel):
    description: str
    name: str
    location: str = None
    area: str = None
    class_: str = None
    quantity: int
    max_quantity: int


class MedicationBase(Base):
    __tablename__ = "Medicine"
    id = Column(Integer, primary_key=True, index=True)
    description = Column(String)
    name = Column(String)
    location = Column(String)
    area = Column(String)
    class_ = Column(String)
    quantity = Column(Integer)
    max_quantity = Column(Integer)


class User(BaseModel):
    id: int
    name: str
    email: str
    password: str
    identification_code: str

class UserBase(Base):
    __tablename__ = "User"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    email = Column(String)
    password = Column(String)
    identification_code = Column(String)
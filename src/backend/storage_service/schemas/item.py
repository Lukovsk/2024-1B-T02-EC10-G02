
from pydantic import BaseModel
from typing import Optional

class CreateItemSchema(BaseModel):
    name: str
    area: Optional[str] = None
    description: Optional[str] = None

class CreateMedSchema(BaseModel):
    name: str
    area: Optional[str] = None
    description: Optional[str] = None
    lot: Optional[int] = None
    medClass: Optional[str] = None
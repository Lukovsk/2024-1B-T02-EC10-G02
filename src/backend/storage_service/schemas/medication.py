
from pydantic import BaseModel
from typing import Optional

class MedSchema(BaseModel):
    id: str
    area: str
    name: str
    description: str
    lot: int
    medClass: str
    isMedication: bool


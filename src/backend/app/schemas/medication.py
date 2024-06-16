
from pydantic import BaseModel
from typing import Optional

class MedSchema(BaseModel):
    #id: str
    area: str
    description: str
    lot: int
    medClass: str

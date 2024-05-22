
from pydantic import BaseModel

class MedSchema(BaseModel):
    #id: str
    area: str
    description: str
    lot: int
    medClass: str

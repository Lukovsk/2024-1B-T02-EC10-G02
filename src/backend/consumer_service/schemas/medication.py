from pydantic import BaseModel


class MedSchema(BaseModel):
    area: str
    description: str
    lot: int
    medClass: str

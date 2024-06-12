from pydantic import BaseModel
from typing import Optional, List


class CreatePyxiSchema(BaseModel):
    name: str
    reference: Optional[str] = None
    sector: Optional[str] = None
    ala: Optional[str] = None
    floor: Optional[str] = None
    items: Optional[List[str]] = None

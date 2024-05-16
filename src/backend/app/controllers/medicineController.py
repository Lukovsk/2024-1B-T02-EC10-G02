from fastapi import HTTPException
import asyncio
from prisma import Prisma
from  services.medication import MedicationService
from prisma.models import Medications, Request

class MedicineController:
    @staticmethod
    async def get_medication(id: int) -> Medications:
        return await MedicationService.get_medication(id)
    
    @staticmethod
    async def get_all_medications() -> list[Medications]:
        return await MedicationService.get_all_medications()
    
    @staticmethod
    async def create_medication(medication: Medications):
        return await MedicationService.create_medication(medication)

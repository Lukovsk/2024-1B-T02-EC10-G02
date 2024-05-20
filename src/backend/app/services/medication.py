import asyncio
from prisma import Prisma
from prisma.models import Medications, Request

class MedicationService():
    async def get_medication(id: int) -> Medications:
        db = Prisma(auto_register=True)
        await db.connect()
        medication = await Medications.prisma().find_unique(where={'id': id})
        await db.disconnect()
        return medication
    
    async def get_all_medications() -> list[Medications]:
        db = Prisma(auto_register=True)
        await db.connect()
        medications = await Medications.prisma().find_many()
        await db.disconnect()
        return medications
    
    async def create_medication(medication: Medications):
        db = Prisma(auto_register=True)
        await db.connect()
        medication = await Medications.prisma().create_many(
            data = medication
        )
        await db.disconnect()
        return
import asyncio
from prisma import Prisma, errors
from prisma.models import Medications
from contextlib import asynccontextmanager
from __init__ import db


class MedicationService():
    def __init__(self, area="", description="", lot=None, medClass="", id=""):
        self.area = area
        self.description = description
        self.lot = lot
        self.medClass = medClass
        self.id = id

    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    async def create_medication(self) -> Prisma.medications:
        async with self.database_connection():
            try:
                medication = await db.medications.find_first_or_raise(
                    where={
                        "description": self.description
                    },
                )
                raise NameError("Medication already exists")
            except errors.RecordNotFoundError:
                medication = await db.medications.create(
                    data={
                        "area": self.area,
                        "description": self.description,
                        "lot": self.lot,
                        "medClass": self.medClass
                    }
                )
                return medication  

    async def get_all_medications(self):
        async with self.database_connection():
            all_medication = await self.db.medications.find_many()
        return all_medication

    async def get_medication_by_id(self, id: str) -> Medications:
        async with self.database_connection():
            medication = await db.medications.find_unique_or_raise(
                where={
                    "id": self.id
                },
            )
            return medication

    async def update_medication_by_id(self, id: str, update_data) -> Medications:
        async with self.database_connection() as db:
            try:
                # Check if the medication exists before updating
                await db.medications.find_unique_or_raise(
                    where={
                        "id": id
                    }
                )
                
                # Perform the update operation
                updated_medication = await db.medications.update(
                    where={
                        "id": id
                    },
                    data=update_data
                )

                return updated_medication

            except errors.RecordNotFoundError:
                raise ValueError("Medication not found")

    async def delete_medication(self, id: str) -> None:
        async with self.database_connection() as db:
            try:
                # Check if the medication exists before deleting
                await db.medications.find_unique_or_raise(
                    where={
                        "id": id
                    }
                )
                # Perform the delete operation
                await db.medications.delete(
                    where={
                        "id": id
                    }
                )
            except errors.RecordNotFoundError:
                raise ValueError("Medication not found")

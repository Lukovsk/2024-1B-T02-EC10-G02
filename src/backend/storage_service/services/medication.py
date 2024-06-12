import asyncio
from prisma import Prisma, errors
from prisma.models import Item
from contextlib import asynccontextmanager
from __init__ import db


class ItemService():
    def __init__(self, area="", name="", description="", lot=None, medClass="", id="",isMedication=""):
        self.area = area
        self.name = name
        self.description = description
        self.lot = lot
        self.medClass = medClass
        self.id = id
        self.isMedication = isMedication

    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    async def create_medication(self) -> Prisma.item:
        async with self.database_connection():
            try:
                medication = await db.item.find_first_or_raise(
                    where={
                        "id": self.id,
                    },
                )
                raise NameError("Medication already exists")
            except errors.RecordNotFoundError:
                if self.isMedication:
                    medication = await db.item.create(
                        data={
                            "area": self.area,
                            "name": self.name,
                            "description": self.description,
                            "lot": self.lot,
                            "medClass": self.medClass,
                            "isMedication": self.isMedication

                        }
                    )
                    return medication
                else:
                    raise NameError("Medication is not a medication")
    
    async def create_item(self) -> Prisma.item:
        async with self.database_connection():
            try:
                medication = await db.item.find_first_or_raise(
                    where={
                        "id": self.id,
                    },
                )
                raise NameError("Item already exists")
            except errors.RecordNotFoundError:
                if not self.isMedication:
                    medication = await db.item.create(
                        data={
                            "area": self.area,
                            "name": self.name,
                            "description": self.description,
                            "lot": self.lot,
                            "medClass": self.medClass,
                            "isMedication": self.isMedication

                        }
                    )
                    return medication
                else:
                    raise NameError("Item is not a item")

    async def get_all_Item(self):
        async with self.database_connection():
            all_medication = await self.db.item.find_many()
        return all_medication

    async def get_medication_by_id(self, id: str) -> Item:
        async with self.database_connection():
            medication = await db.item.find_unique_or_raise(
                where={
                    "id": self.id
                },
            )
            return medication

    async def update_medication_by_id(self, id: str, update_data) -> Item:
        async with self.database_connection() as db:
            try:
                # Check if the medication exists before updating
                await db.Item.find_unique_or_raise(
                    where={
                        "id": id
                    }
                )

                # Perform the update operation
                updated_medication = await db.item.update(
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
                await db.item.find_unique_or_raise(
                    where={
                        "id": id
                    }
                )
                # Perform the delete operation
                await db.item.delete(
                    where={
                        "id": id
                    }
                )
            except errors.RecordNotFoundError:
                raise ValueError("Medication not found")

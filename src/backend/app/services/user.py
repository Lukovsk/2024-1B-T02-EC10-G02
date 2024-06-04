from __init__ import db
from prisma import Prisma, errors
from contextlib import asynccontextmanager
import bcrypt

class UserService():
    def __init__(self, name="", email="", password="", id=""):
        self.name = name
        self.email = email
        self.password = password
        self.id = id
    
    
    
    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()

    def encrypt_password(self, password: str) -> str:
        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
        return hashed_password.decode('utf-8')

    async def create_user(self) -> Prisma.user:
        async with self.database_connection():
            try:
                user = await self.db.user.find_first_or_raise(
                    where={
                        "email": self.email
                    },
                )

                raise NameError("User already exists")
            except errors.RecordNotFoundError:
                user = await self.db.user.create(
                    data={
                        "email": self.email,
                        "name": self.name,
                        "password": self.encrypt_password(self.password)
                    }
                )
                return user

    async def get_all_users(self):
        async with self.database_connection():
            users = await self.db.user.find_many()
        return users
    
    async def get_user_by_id(self):
        async with self.database_connection():
            user = await self.db.user.find_unique_or_raise(
                where={
                    "id": self.id
                },
            )
            return user
    
    async def update_user_by_id(self, update_data) -> Prisma.user:
        async with self.database_connection():
            try:
                # Check if the user exists before updating
                await self.db.user.find_unique_or_raise(
                    where={
                        "id": self.id
                    }
                )
                
                # Perform the update operation
                updated_user = await self.db.user.update(
                    where={
                        "id": self.id
                    },
                    data=update_data
                )

                return updated_user

            except errors.RecordNotFoundError:
                raise ValueError("User not found")     
            

    async def delete_user(self, id: str) -> None:
        print (id)
        async with self.database_connection():
            try:
                # Check if the user exists before deleting
                await self.db.user.find_unique_or_raise(
                    where={
                        "id": id
                    }
                )
                # Perform the delete operation
                await self.db.user.delete(
                    where={
                        "id": id
                    }
                )
            except errors.RecordNotFoundError:
                raise ValueError("User not found")

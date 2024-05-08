from __init__ import db
from contextlib import asynccontextmanager
import bcrypt

class UserService():
    def __init__(self, name, email, password, id):
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
               user = await self.db.user.find_unique_or_raise(
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
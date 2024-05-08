from __init__ import db
from contextlib import asynccontextmanager

class RequestService():
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


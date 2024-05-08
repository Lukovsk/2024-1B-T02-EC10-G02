from __init__ import db
from contextlib import asynccontextmanager

class RequestService():
    def __init__(self, id=None, medicationId=None, status=None):
        pass
    
    
    
    @asynccontextmanager
    async def database_connection(self):
        self.db = db
        await self.db.connect()
        try:
            yield
        finally:
            await self.db.disconnect()


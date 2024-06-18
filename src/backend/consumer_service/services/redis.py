import redis
import os
from dotenv import load_dotenv

load_dotenv()


class RedisService:
    def __init__(self):
        self.client = redis.Redis(
            host=os.getenv("REDIS_HOST", "localhost"),
            port=os.getenv("REDIS_PORT", 11060),
            password=os.getenv("REDIS_PSWD", "ritalinos"),
        )
        self.alive = True
        self.first_ping = False

    def setex(self, name, time, value):
        if not self.alive:
            return

        self.client.setex(name, time, value)

    def get(self, name):
        if not self.first_ping:
            self._ping()

        if not self.alive:
            return None
        return self.client.get(name)

    def _ping(self):
        try:
            ping = self.client.ping()
            print(ping)
            if ping:
                self.alive = True
            self.first_ping = True
        except Exception as e:
            self.alive = False
            print("Connection with redis failed")


redis_client = RedisService()

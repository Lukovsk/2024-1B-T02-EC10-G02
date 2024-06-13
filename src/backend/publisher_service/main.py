from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import order_pub_router
import os

app = FastAPI()


origins = [
    "http://localhost:3001",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(order_pub_router)

if __name__ == "__main__":
    import uvicorn
    import os

    #if "RABBITMQ_HOST" in os.environ:

    uvicorn.run(app, host="0.0.0.0", port=3001)

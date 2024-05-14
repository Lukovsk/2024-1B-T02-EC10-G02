from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from prismaClient import prismaClient

from routes import user_router, order_router #, feedback_router

@asynccontextmanager
async def lifespan(app: FastAPI):
    await prismaClient.connect()
    yield
    await prismaClient.disconnect()

    
app = FastAPI(lifespan=lifespan)

origins = [
    "http://localhost:3000",  
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user_router)
# app.include_router(feedback_router)
app.include_router(order_router)

# app.include_router()

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=3000)
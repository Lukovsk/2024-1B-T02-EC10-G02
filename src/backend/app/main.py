from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from routes.userRouter import router as userRouter
from routes.feedbackRoutes import feedback_routes
from prismaClient import prismaClient

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

app.include_router(userRouter)
app.include_router(feedback_routes)

# app.include_router()

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=3003)
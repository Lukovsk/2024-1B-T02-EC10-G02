from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import (
    user_router,
    order_router,
    itens_router,
    pyxis_router,
)


@asynccontextmanager
async def lifespan(app: FastAPI):
    from prisma import Prisma

    prismaClient = Prisma()

    await prismaClient.connect()
    yield
    await prismaClient.disconnect()


app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user_router)
app.include_router(order_router)
app.include_router(itens_router)
app.include_router(pyxis_router)

if __name__ == "__main__":
    import uvicorn
    import os

    uvicorn.run(app, host="0.0.0.0", port=3000)

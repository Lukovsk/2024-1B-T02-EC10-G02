from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from logs.logger import setup_logger
from prismaClient import prismaClient
from routes import user_router, order_router  # , feedback_router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await prismaClient.connect()
    yield
    await prismaClient.disconnect()


app = FastAPI(lifespan=lifespan)
logger = setup_logger('main')

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
    import uvicorn
    import os

    if "RABBITMQ_HOST" in os.environ:
        import threading
        from routes.queue import app as queue_router
        from controllers.queue import create_order_queue

        try:
            thread = threading.Thread(target=create_order_queue)
            thread.start()

            app.include_router(queue_router)

            uvicorn.run(app, host="0.0.0.0", port=3000)
        except Exception as e:
            print(f"Finalizando fila: {e}")
            thread.stop()
    else:
        print(
            "HOST e PORT do RabbitMQ deveriam estar no .env, iniciando sem conexão com a fila"
        )
        uvicorn.run(app, host="0.0.0.0", port=3000)

from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from logs.logger import setup_logger
from prismaClient import prismaClient
from routes import user_router, order_router, queue_router, medication_router # , feedback_router
import os

#import threading
#from queueConfig import create_order_queue, update_order_queue, cancel_order_queue

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
app.include_router(medication_router)
app.include_router(order_router)
app.include_router(queue_router)

# app.include_router()
# def start_queue_publishers():
#     if "RABBITMQ_HOST" in os.environ:
#         try:
#             create_thread = threading.Thread(target=create_order_queue)
#             update_thread = threading.Thread(target=update_order_queue)
#             cancel_thread = threading.Thread(target=cancel_order_queue)

#             create_thread.start()
#             update_thread.start()
#             cancel_thread.start()

#             return create_thread, update_thread, cancel_thread
#         except Exception as e:
#             print(f"Error starting queue consumers: {e}")
#             raise
#     else:
#         print("HOST and PORT for RabbitMQ should be set in the environment variables.")

if __name__ == "__main__":
    import uvicorn
    import os

    #if "RABBITMQ_HOST" in os.environ:

        #threads = start_queue_publishers()
        #try:
    uvicorn.run(app, host="0.0.0.0", port=3000)
    #     except Exception as e:
    #         print(f"Shutting down: {e}")
    #         for thread in threads:
    #             thread.join()
    # else:
    #     print(
    #         "HOST e PORT do RabbitMQ deveriam estar no .env, iniciando sem conexão com a fila"
    #     )
    #     uvicorn.run(app, host="0.0.0.0", port=3000)
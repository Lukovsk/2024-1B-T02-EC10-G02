# Serviço 2 - recebe as mensagens via RabbitMQ e as armazena em um banco de dados em memória

from fastapi import FastAPI
from contextlib import asynccontextmanager
from pydantic import BaseModel
from datetime import datetime
from fastapi.middleware.cors import CORSMiddleware
from prismaClient import prismaClient
import threading
import pika
import os
from services.queueConfig import consume_order_queue
# Ajuste para tentar reconectar ao RabbitMQ
from pika.connection import Parameters
Parameters.DEFAULT_CONNECTION_ATTEMPTS = 10


@asynccontextmanager
async def lifespan(app: FastAPI):
    await prismaClient.connect()
    yield
    await prismaClient.disconnect()


app = FastAPI(lifespan=lifespan)

origins = [
    "http://localhost:3001",
]

# Middleware de CORS (caso necessário)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# class Message(BaseModel):
#     date: datetime = None
#     msg: str



# @app.get("/messages")
# async def get_messages():
#     return banco_em_memoria

# Executa a aplicação com a informação de HOST e PORTA enviados por argumentos
if __name__ == "__main__":
    import uvicorn
    import os
    #if "RABBITMQ_HOST" in os.environ:
    try:    
        # Cria uma thread para receber as mensagens do RabbitMQ
        thread = threading.Thread(target=consume_order_queue)
        thread.start()
        uvicorn.run(app, host="0.0.0.0", port=3001)
    except Exception as e:
        print(f"Finalizando a execução da thread: {e}")
        thread.stop()
else:
    raise Exception("HOST and PORT must be defined in environment variables")


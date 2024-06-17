# Serviço 2 - recebe as mensagens via RabbitMQ e as armazena em um banco de dados em memória
from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI
from routes import user_router, order_router, pyxis_router
from pika.connection import Parameters

Parameters.DEFAULT_CONNECTION_ATTEMPTS = 10

app = FastAPI()

# Middleware de CORS (caso necessário)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(user_router)
app.include_router(order_router)
app.include_router(pyxis_router)

# Executa a aplicação com a informação de HOST e PORTA enviados por argumentos
if __name__ == "__main__":
    import uvicorn
    import os

    try:
        uvicorn.run(app, host="0.0.0.0", port=3002)
    except Exception as e:
        print("Fatal error: {e}")

else:
    raise Exception("HOST and PORT must be defined in environment variables")

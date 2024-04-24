from fastapi import FastAPI
from .database.database import SessionLocal

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def register_routes():
    from .routes.medicineRoutes import medication_routes
    from .routes.userRoutes import user_routes
    app.include_router(user_routes)
    app.include_router(medication_routes)

register_routes()

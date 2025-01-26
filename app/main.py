import logging

from fastapi import FastAPI
from app.db.database import Base, engine
from app.api.routes import router
from app.core.config import config

logger = logging.getLogger(__name__)

def create_app() -> FastAPI:
    Base.metadata.create_all(bind=engine)  # Initialize database
    app = FastAPI(
        title="FastAPI Task Manager",
        debug=config.APP_DEBUG  # Toggle FastAPI's debug mode
    )
    app.include_router(router)

    if config.APP_ENV == "development":
        Database = config.DATABASE_URL
        logger.info('Here is Database', Database)
        print('Here is Database', Database)

        print("🚀 Running in Development Mode!")
    elif config.APP_ENV == "production":
        print("🔒 Running in Production Mode!")

    return app

app = create_app()

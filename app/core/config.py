import os
from dotenv import load_dotenv

load_dotenv()  # Load .env file

class Config:
    APP_ENV = os.getenv("APP_ENV", "production")  # Default to production
    APP_DEBUG = os.getenv("APP_DEBUG", "False").lower() in ("true", "1", "yes")
    DATABASE_URL = os.getenv("DATABASE_URL")
    # SECRET_KEY = os.getenv("SECRET_KEY", "default_secret_key")

config = Config()

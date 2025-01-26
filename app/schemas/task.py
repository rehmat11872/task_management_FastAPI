from pydantic import BaseModel

class TaskCreate(BaseModel):
    title: str
    description: str = None
    user_id: int

class TaskResponse(TaskCreate):
    id: int

    class Config:
        orm_mode = True

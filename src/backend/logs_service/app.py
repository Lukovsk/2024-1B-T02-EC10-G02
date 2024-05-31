from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import datetime
import uvicorn
from elasticsearch import Elasticsearch, exceptions

app = FastAPI()
es = Elasticsearch(["http://localhost:9200"])

class LogEntry(BaseModel):
    service: str
    user_id: str
    action: str
    result: str
    cause: str = None
    timestamp: datetime.datetime = None

def index_log(log_entry: LogEntry, index_name: str):
    if not log_entry.timestamp:
        log_entry.timestamp = datetime.datetime.now()
    response = es.index(
        index=index_name,
        body=log_entry.dict()
    )
    return {"status": "success", "log_id": response["_id"]}

@app.post("/log")
async def log_action(log_entry: LogEntry):
    result = index_log(log_entry, "log")
    return result

@app.post("/ping")
async def ping():
    return {"status": "success"}

@app.get("/")
async def get_logs():
    try:
        logs = {}
        indices = ["log"]
        for index in indices:
            response = es.search(index=index, body={"query": {"match_all": {}}})
            logs[index] = [hit["_source"] for hit in response["hits"]["hits"]]
        return logs
    except exceptions.ConnectionError:
        raise HTTPException(status_code=500, detail="Elasticsearch connection error")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8003)
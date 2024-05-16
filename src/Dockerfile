FROM python:3.8-slim

WORKDIR /backend

COPY backend/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY backend/app ./app

EXPOSE 3000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "3000", "--reload"]

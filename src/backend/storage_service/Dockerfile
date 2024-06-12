FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

RUN prisma generate

EXPOSE 3000

CMD ["python", "app/main.py"]

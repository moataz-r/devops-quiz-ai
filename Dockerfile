FROM python:3.11-slim AS base

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python -c "import db; db.init_db()"

ENV PORT=5000

EXPOSE $PORT

CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:$PORT --workers 2 app:app"]
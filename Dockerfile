FROM python:3.11.0

WORKDIR /app

COPY requirements.txt /app
COPY .env /app

RUN pip install -r requirements.txt

WORKDIR /app/src

CMD python manage.py runserver 0.0.0.0:8000
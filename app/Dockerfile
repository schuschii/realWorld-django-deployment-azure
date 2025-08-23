FROM python:3.10-slim-bullseye

WORKDIR /app

RUN apt-get update \
    && apt-get install -y libpq-dev postgresql-client curl \
    && apt-get install -y gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --upgrade pip 

COPY ./requirements.txt .

RUN pip install -r requirements.txt 

COPY . .

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
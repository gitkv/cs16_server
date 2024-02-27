FROM python:3.8-slim

WORKDIR /app

COPY ./stats/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY ./stats /app

RUN pip install --no-cache-dir flask

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

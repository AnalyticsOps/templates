FROM python:3.8-slim

COPY src/ /app
WORKDIR /app

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-transport-https
RUN pip3 install --upgrade twine wheel setuptools
RUN pip3 install -r requirements.txt

EXPOSE 8000

CMD uvicorn --host 0.0.0.0 --port 8000 app:app

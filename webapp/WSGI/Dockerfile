FROM python:3.8-slim

COPY src/ /app
WORKDIR /app

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-transport-https
RUN pip3 install --force-reinstall 'pip==20.0.2'
RUN pip3 install --upgrade twine wheel setuptools
RUN pip3 install -r requirements.txt --pre

EXPOSE 8000

CMD gunicorn -b 0.0.0.0:80 app:app

FROM python:3.6-slim-buster

WORKDIR /app


RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && apt-get install -y python3-venv && python -m pip install --upgrade pip && pip install wheel 

COPY ./entrypoint.sh /.

RUN chmod +x /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"] 





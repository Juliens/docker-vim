FROM debian:latest
RUN apt-get update && apt-get install vim-nox && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY ./:/root


#!/bin/bash
git pull
docker build -t docker-wechatbot-webhook:latest .

if [ "$(docker ps -qaf name=wxBotWebhook)" != "" ]
then docker kill $(docker ps -qf name=wxBotWebhook)
fi
if [ "$(docker ps -qaf name=wxBotWebhook)" != "" ]
then
  docker rm $(docker ps -qaf name=wxBotWebhook)
fi
docker run -d --name wxBotWebhook -p 3001:3001 -e RECVD_MSG_API=http://192.168.0.254:8999/api/wxMessage -e LOGIN_API_TOKEN=wx docker-wechatbot-webhook
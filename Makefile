include .env

.PHONY: all

build:
	docker build -t chatbot-ui .

run:
	export $(cat .env | xargs)
	docker stop chatbot-ui || true && docker rm chatbot-ui || true
	docker run --name chatbot-ui --rm -e OPENAI_API_KEY=${OPENAI_API_KEY} -p 3000:3000 chatbot-ui

logs:
	docker logs -f chatbot-ui

push:
	aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 557719627116.dkr.ecr.ap-northeast-1.amazonaws.com
	docker tag chatbot-ui:latest 557719627116.dkr.ecr.ap-northeast-1.amazonaws.com/chatbot-ui:latest
	docker push 557719627116.dkr.ecr.ap-northeast-1.amazonaws.com/chatbot-ui:latest

# vue cli 3
FROM alpine:3.8 as vue-cli-3
ENV VER 3.6.2

COPY ./repositories /etc/apk/repositories

RUN \
  apk add npm --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main && \
  npm i yarn -g && \
  # work directories
  mkdir /code && \
  # global packages
  yarn global add @vue/cli@$VER && \
  echo '### 1.Finish ###'

WORKDIR /code
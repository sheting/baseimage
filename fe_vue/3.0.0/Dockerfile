# vue cli 3
FROM alpine:3.8 as vue-cli-3

RUN \
  apk add npm --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main && \
  npm i yarn -g && \
  # work directories
  mkdir /code && \
  # global packages
  yarn global add @vue/cli && \
  echo '### 1.Finish ###'

WORKDIR /code
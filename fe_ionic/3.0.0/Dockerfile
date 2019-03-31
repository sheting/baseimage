# ionic v3
FROM alpine:3.8

#RUN echo -e 'http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/main\nhttp://mirrors.tuna.tsinghua.edu.cn/alpine/v3.8/community' > /etc/apk/repositories

RUN \
#	apk add npm --update && \
  apk add npm --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main && \
  npm i -g ionic@latest && \
  mkdir /code && \
  echo '### 1. Ionic env Finished!'

WORKDIR /code

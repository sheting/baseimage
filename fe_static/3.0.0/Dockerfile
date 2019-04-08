# static as service
FROM alpine:3.8

RUN \
  apk add nginx --update --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/main && \
  mkdir /srv/web-app && \
  echo '### 3.Finish ###'

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 81
CMD ["nginx", "-g", "daemon off;"]
FROM alpine:3.8

RUN echo -e 'http://mirrors.ustc.edu.cn/alpine/v3.8/main\nhttp://mirrors.ustc.edu.cn/alpine/v3.8/community\n' > /etc/apk/repositories
RUN apk add --no-cache \
    bash \
    nodejs-npm \
    python \
    make \
    g++ \
    libc6-compat \
    jq \
    curl

ENTRYPOINT ["/bin/bash"]


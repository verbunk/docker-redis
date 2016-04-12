FROM alpine:3.2 

RUN addgroup -S redis && adduser -S -G redis redis

RUN apk add --update redis ca-certificates bash supervisor
RUN rm -rf /var/cache/apk/* 

RUN mkdir -pv /redis/conf /var/log/supervisor /redis/run /redis/data && chown -R redis:redis /redis

ADD super-redis.conf /redis/conf/redis.super
ADD supervisord.conf /etc/supervisord.conf

VOLUME /redis/data
WORKDIR /data
EXPOSE 6379 

CMD [ "supervisord" ]

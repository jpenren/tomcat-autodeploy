FROM alpine:3.8

RUN apk --no-cache add curl inotify-tools

COPY entrypoint.sh /
COPY autodeploy.sh /

RUN chmod +x /entrypoint.sh && chmod +x /autodeploy.sh && mkdir /autodeploy

ENTRYPOINT ["/entrypoint.sh"]
CMD ["tomcat"]
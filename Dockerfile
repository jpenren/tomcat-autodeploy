FROM alpine:3.8

RUN apk --no-cache add curl inotify-tools

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Default server name
CMD ["tomcat"]

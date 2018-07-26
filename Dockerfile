FROM alpine:3.8

RUN apk --no-cache add curl inotify-tools

#RUN apk --update upgrade && \
#    apk add --update inotify-tools && \
#    apk add curl && \
#    rm -rf /var/cache/apk/*


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Default server name
CMD ["localhost"]

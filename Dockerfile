FROM alpine:3.8

ENV TOMCAT_USERNAME=tomcat
ENV TOMCAT_PASSWORD=s3cret

RUN apk add --update --no-cache python curl

ADD server.py /server.py

ENTRYPOINT ["python", "/server.py"]

# Default server name
CMD ["tomcat"]

FROM openjdk:8-jre-alpine

#ARG BUILD_DATE
ARG SOURCE_COMMIT
ARG DOCKER_TAG
#LABEL org.label-schema.build-date=$BUILD_DATE \
LABEL org.label-schema.name="Mirth Containerized" \
      org.label-schema.description="Mirth Containerized for easy deployment in AWS or any production enviroment running Docker via docker standalone, docker-compose, or even a docker swarm." \
      org.label-schema.url="https://hub.docker.com/r/michaelleehobbs/mirth" \
      org.label-schema.vcs-ref=$SOURCE_COMMIT \
      org.label-schema.vcs-url="https://github.com/MichaelLeeHobbs/Mirth" \
      org.label-schema.version=$DOCKER_TAG \
      org.label-schema.schema-version="1.0"

ENV MIRTH_CONNECT_VERSION 3.7.1.b243

RUN apk add curl tar sed rsync
RUN curl http://downloads.mirthcorp.com/connect/$MIRTH_CONNECT_VERSION/mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz -o mirth.tar.gz \
    && /usr/bin/tar -xzf ./mirth.tar.gz \
    && mv Mirth\ Connect /opt/mirthconnect \
    && rm -f mirth.tar.gz \
    && mkdir /opt/mirthconnect/confbase \
    && cp /opt/mirthconnect/conf/*.* /opt/mirthconnect/confbase/

COPY start.sh /opt/mirthconnect/
COPY mcserver.vmoptions /opt/mirthconnect/confbase/
COPY mirth.properties /opt/mirthconnect/confbase/

RUN chmod +x /opt/mirthconnect/start.sh && mkdir /opt/mirthconnect/appdata

EXPOSE 8080 8443

CMD /opt/mirthconnect/start.sh

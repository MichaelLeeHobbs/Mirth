FROM openjdk:8-jre-alpine

# ENV MIRTH_CONNECT_VERSION 3.6.1.b220
ENV MIRTH_CONNECT_VERSION 3.7.0.b2399

RUN apk add curl tar sed rsync
RUN curl http://downloads.mirthcorp.com/connect/$MIRTH_CONNECT_VERSION/mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz -o mirth.tar.gz
RUN /usr/bin/tar -xzf ./mirth.tar.gz && mv Mirth\ Connect /opt/mirthconnect && rm -f mirth.tar.gz

COPY start.sh /opt/mirthconnect/
COPY mcserver.vmoptions /opt/mirthconnect/confbase/
COPY mirth.properties /opt/mirthconnect/confbase/

RUN chmod +x /opt/mirthconnect/start.sh && mkdir /opt/mirthconnect/appdata

EXPOSE 8080 8443

CMD /opt/mirthconnect/start.sh

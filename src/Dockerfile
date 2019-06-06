FROM openjdk:8-jre-alpine

# ENV MIRTH_CONNECT_VERSION 3.6.1.b220
ENV MIRTH_CONNECT_VERSION 3.7.0.b2399

RUN apk add curl tar sed rsync
RUN curl http://downloads.mirthcorp.com/connect/$MIRTH_CONNECT_VERSION/mirthconnect-$MIRTH_CONNECT_VERSION-unix.tar.gz -o mirth.tar.gz
RUN /usr/bin/tar -xzf ./mirth.tar.gz && mv Mirth\ Connect /opt/mirthconnect

#COPY envSetup.sh /opt/mirthconnect/
COPY start.sh /opt/mirthconnect/
RUN sed -i 's/-Xmx256m/-Xmx1024m/g' /opt/mirthconnect/mcserver.vmoptions \
    && sed -i 's/-Xmx256m/-Xmx1024m/g' /opt/mirthconnect/mcservice.vmoptions \
    && sed -i 's|database = derby|database = ${DB_TYPE}|g' /opt/mirthconnect/conf/mirth.properties \
    && sed -i 's|database.url = jdbc:derby:\${dir.appdata}/mirthdb;create=true|database.url = jdbc:${DB_TYPE_JDBC}://${DB_HOST}:${DB_PORT}/${DB_NAME}|g' /opt/mirthconnect/conf/mirth.properties \
    && sed -i 's|database.username =|database.username = ${DB_USERNAME}|g' /opt/mirthconnect/conf/mirth.properties \
    && sed -i 's|database.password =|database.password = ${DB_PASSWORD}|g' /opt/mirthconnect/conf/mirth.properties \
#    && sed -i '/start com.mirth.connect.server.launcher.MirthLauncher/a\echo $! > /var/run/mcservice.pid' /opt/mirthconnect/mcservice \
#    && sed -i '/com.install4j.runtime.launcher.Launcher stop/a\rm /var/run/mcservice.pid' /opt/mirthconnect/mcservice \
    && rm -f mirth.tar.gz \
#    && chmod +x /opt/mirthconnect/envSetup.sh
    && chmod +x /opt/mirthconnect/start.sh \
#    && chown root:root /opt/mirthconnect/appdata
    && mkdir /opt/mirthconnect/appdata \
    && mkdir /opt/mirthconnect/confbase \
    && cp /opt/mirthconnect/conf/*.* /opt/mirthconnect/confbase/

EXPOSE 8080 8443 5000

CMD /opt/mirthconnect/start.sh
#CMD /opt/mirthconnect/envSetup.sh \
#    && /opt/mirthconnect/mcservice restart \
#    && tail -F /opt/mirthconnect/logs/mirth.log

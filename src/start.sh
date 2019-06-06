#!/bin/sh
rsync -a -v --ignore-existing /opt/mirthconnect/confbase/ /opt/mirthconnect/conf

/bin/sed -i "s|\${DB_TYPE}|$DB_TYPE|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_TYPE_JDBC}|$DB_TYPE_JDBC|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_HOST}|$DB_HOST|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_PORT}|$DB_PORT|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_NAME}|$DB_NAME|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_USERNAME}|$DB_USERNAME|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_PASSWORD}|$DB_PASSWORD|g" /opt/mirthconnect/conf/mirth.properties


#       Derby           jdbc:derby:${dir.appdata}/mirthdb;create=true
#       PostgreSQL      jdbc:postgresql://localhost:5432/mirthdb
#       MySQL           jdbc:mysql://localhost:3306/mirthdb
#       Oracle          jdbc:oracle:thin:@localhost:1521:DB
#       SQLServer       jdbc:jtds:sqlserver://localhost:1433/mirthdb

#rm /opt/mirthconnect/appdata/keystore.jks
cd /opt/mirthconnect
/usr/lib/jvm/default-jvm/jre/bin/java \
    -Dinstall4j.jvmDir=/usr/lib/jvm/default-jvm/jre \
    -Dexe4j.moduleName=/opt/mirthconnect/mcservice \
    -Dinstall4j.launcherId=144 -Dinstall4j.swt=false \
    -Di4jv=0 -Di4jv=0 -Di4jv=0 -Di4jv=0 -Di4jv=0 -server \
    -Xmx1024m -Djava.awt.headless=true -Dapple.awt.UIElement=true \
    -Di4j.vpt=true -classpath /opt/mirthconnect/.install4j/i4jruntime.jar:/opt/mirthconnect/mirth-server-launcher.jar \
    com.install4j.runtime.launcher.UnixLauncher start 69b090a9 0 0 com.mirth.connect.server.launcher.MirthLauncher

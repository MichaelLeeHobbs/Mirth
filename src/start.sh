#!/bin/sh

# keystore - keep any existing values
FILE="/opt/mirthconnect/conf/mirth.properties"
if [[ -f ${FILE} ]]; then
    KEYSTORE_PATH="$(cat /opt/mirthconnect/conf/mirth.properties | grep -o "keystore\.path\s=\s.*" | grep -o '[^ ]*$')"
    KEYSTORE_PATH="${KEYSTORE_PATH:-${dir.appdata}/keystore.jks}"
    KEYSTORE_STOREPASS="$(cat /opt/mirthconnect/conf/mirth.properties | grep -o "keystore\.storepass\s=\s.*" | grep -o '[^ ]*$')"
    KEYSTORE_KEYPASS="$(cat /opt/mirthconnect/conf/mirth.properties | grep -o "keystore\.keypass\s=\s.*" | grep -o '[^ ]*$')"
    KEYSTORE_TYPE="$(cat /opt/mirthconnect/conf/mirth.properties | grep -o "keystore\.type\s=\s.*" | grep -o '[^ ]*$')"
else
    KEYSTORE_PATH="\${dir.appdata}/keystore.jks"
    KEYSTORE_STOREPASS=""
    KEYSTORE_KEYPASS=""
    KEYSTORE_TYPE=""
fi

# setup template files
# unalias cp to make sure no overwrite issues
yes | cp -rf /opt/mirthconnect/confbase/mirth.properties /opt/mirthconnect/conf/mirth.properties
yes | cp -rf /opt/mirthconnect/confbase/mcserver.vmoptions /opt/mirthconnect/conf/mcserver.vmoptions

# write keystore values
/bin/sed -i "s|\${KEYSTORE_PATH}|$KEYSTORE_PATH|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${KEYSTORE_STOREPASS}|$KEYSTORE_STOREPASS|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${KEYSTORE_KEYPASS}|$KEYSTORE_KEYPASS|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${KEYSTORE_TYPE}|$KEYSTORE_TYPE|g" /opt/mirthconnect/conf/mirth.properties

# write Admin max heap?
ADMIN_MAX_HEAP="${ADMIN_MAX_HEAP:-512m}"

# write Javascript Version
JS_VER="${JS_VER:-es6}"

# write DB Type
DB_TYPE="${DB_TYPE:-derby}"
/bin/sed -i "s|\${DB_TYPE}|$DB_TYPE|g" /opt/mirthconnect/conf/mirth.properties

# generate DB URL
DB_HOST="${DB_HOST:-db}"
DB_URL="jdbc:derby:\${dir.appdata}/mirthdb;create=true"
if [[ "$DB_TYPE" = "postgres" ]]; then DB_URL = "jdbc:postgresql://${DB_HOST}:${DB_PORT:-5432}/${DB_NAME:-mirthdb}"; fi
if [[ "$DB_TYPE" = "mysql" ]]; then DB_URL = "jdbc:mysql://${DB_HOST}:${DB_PORT:-3306}/${DB_NAME:-mirthdb}"; fi
if [[ "$DB_TYPE" = "oracle" ]]; then DB_URL = "jdbc:oracle:thin:@${DB_HOST}:${DB_PORT:-1521}/${DB_NAME:-DB}"; fi
if [[ "$DB_TYPE" = "sqlserver" ]]; then DB_URL = "jdbc:jtds:sqlserver://${DB_HOST}:${DB_PORT:-1433}/${DB_NAME:-mirthdb}"; fi
# write DB URL
/bin/sed -i "s|\${DB_URL}|$DB_URL|g" /opt/mirthconnect/conf/mirth.properties

# write DB Creds
/bin/sed -i "s|\${DB_USERNAME}|$DB_USERNAME|g" /opt/mirthconnect/conf/mirth.properties
/bin/sed -i "s|\${DB_PASSWORD}|$DB_PASSWORD|g" /opt/mirthconnect/conf/mirth.properties

# write DB settings
DB_MAX_CONNECTIONS="${DB_MAX_CONNECTIONS:-20}"
/bin/sed -i "s|\${DB_MAX_CONNECTIONS}|$DB_MAX_CONNECTIONS|g" /opt/mirthconnect/conf/mirth.properties
DB_MAX_READONLY_CONNECTIONS="${DB_MAX_READONLY_CONNECTIONS:-20}"
/bin/sed -i "s|\${DB_MAX_READONLY_CONNECTIONS}|$DB_MAX_READONLY_CONNECTIONS|g" /opt/mirthconnect/conf/mirth.properties

# write password settings
PW_MIN_LENGTH="${PW_MIN_LENGTH:-0}"
/bin/sed -i "s|\${PW_MIN_LENGTH}|$PW_MIN_LENGTH|g" /opt/mirthconnect/conf/mirth.properties
PW_MIN_UPPER="${PW_MIN_UPPER:-0}"
/bin/sed -i "s|\${PW_MIN_UPPER}|$PW_MIN_UPPER|g" /opt/mirthconnect/conf/mirth.properties
PW_MIN_LOWER="${PW_MIN_LOWER:-0}"
/bin/sed -i "s|\${PW_MIN_LOWER}|$PW_MIN_LOWER|g" /opt/mirthconnect/conf/mirth.properties
PW_MIN_NUMERIC="${PW_MIN_NUMERIC:-0}"
/bin/sed -i "s|\${PW_MIN_NUMERIC}|$PW_MIN_NUMERIC|g" /opt/mirthconnect/conf/mirth.properties
PW_MIN_SPECIAL="${PW_MIN_SPECIAL:-0}"
/bin/sed -i "s|\${PW_MIN_SPECIAL}|$PW_MIN_SPECIAL|g" /opt/mirthconnect/conf/mirth.properties
PW_RETRY_LIMIT="${PW_RETRY_LIMIT:-0}"
/bin/sed -i "s|\${PW_RETRY_LIMIT}|$PW_RETRY_LIMIT|g" /opt/mirthconnect/conf/mirth.properties
PW_LOCKOUT_PERIOD="${PW_LOCKOUT_PERIOD:-0}"
/bin/sed -i "s|\${PW_LOCKOUT_PERIOD}|$PW_LOCKOUT_PERIOD|g" /opt/mirthconnect/conf/mirth.properties
PW_EXPIRATION="${PW_EXPIRATION:-0}"
/bin/sed -i "s|\${PW_EXPIRATION}|$PW_EXPIRATION|g" /opt/mirthconnect/conf/mirth.properties
PW_GRACE_PERIOD="${PW_GRACE_PERIOD:-0}"
/bin/sed -i "s|\${PW_GRACE_PERIOD}|$PW_GRACE_PERIOD|g" /opt/mirthconnect/conf/mirth.properties
PW_REUSE_PERIOD="${PW_REUSE_PERIOD:-0}"
/bin/sed -i "s|\${PW_REUSE_PERIOD}|$PW_REUSE_PERIOD|g" /opt/mirthconnect/conf/mirth.properties
PW_REUSE_LIMIT="${PW_REUSE_LIMIT:-0}"
/bin/sed -i "s|\${PW_REUSE_LIMIT}|$PW_REUSE_LIMIT|g" /opt/mirthconnect/conf/mirth.properties

# mcserver.vmoptions
# write JVM
JVM_XMX="${JVM_XMX:-1024m}"
/bin/sed -i "s|\${JVM_XMX}|$JVM_XMX|g" /opt/mirthconnect/mcserver.vmoptions


# Start Server
cd /opt/mirthconnect
/usr/lib/jvm/default-jvm/jre/bin/java \
    -Dinstall4j.jvmDir=/usr/lib/jvm/default-jvm/jre \
    -Dexe4j.moduleName=/opt/mirthconnect/mcservice \
    -Dinstall4j.launcherId=144 -Dinstall4j.swt=false \
    -Di4jv=0 -Di4jv=0 -Di4jv=0 -Di4jv=0 -Di4jv=0 -server \
    -Xmx1024m -Djava.awt.headless=true -Dapple.awt.UIElement=true \
    -Di4j.vpt=true -classpath /opt/mirthconnect/.install4j/i4jruntime.jar:/opt/mirthconnect/mirth-server-launcher.jar \
    com.install4j.runtime.launcher.UnixLauncher start 69b090a9 0 0 com.mirth.connect.server.launcher.MirthLauncher

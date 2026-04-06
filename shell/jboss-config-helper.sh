
JBOSS_HOME=/app/jboss-eap
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE-full-ha.xml"}
#export JAVA_HOME=/app/jdk
#export PATH=$PATH:$JAVA_HOME/bin

sed -i 's/<http-interface ssl-context="sslcontext" security-realm="ManagementRealm">/<http-interface security-realm="ManagementRealm">/g' $JBOSS_HOME/standalone/configuration/$JBOSS_CONFIG

if [ x`ps -auwx | grep java | grep -v grep | awk '{print $2}'` == x ]; then

    echo "=> JBOSS is not running"
    echo "=> Starting JBOSS server"

#    $JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -bmanagement 0.0.0.0 -c $JBOSS_CONFIG &
     $JBOSS_HOME/bin/$JBOSS_MODE.sh -b localhost -bmanagement localhost -c $JBOSS_CONFIG &
    sleep 30

fi

if [ z`ps -ef | grep java | awk -v FS="-Djboss.socket.binding.port-offset=" 'NF>1{print $2}' | awk '{ print $1}'` != z ]; then

        MANAGEMENT_CONSOLE_OFFSET=`ps -ef | grep java | awk -v FS="-Djboss.socket.binding.port-offset=" 'NF>1{print $2}' | cut -d' ' -f1`
        MANAGEMENT_CONSOLE_PORT=$((8940+$MANAGEMENT_CONSOLE_OFFSET))
else
        MANAGEMENT_CONSOLE_OFFSET=0
        MANAGEMENT_CONSOLE_PORT=$((8940+$MANAGEMENT_CONSOLE_OFFSET))
fi

JBOSS_CLI="$JBOSS_HOME/bin/jboss-cli.sh --connect controller=remote+https://localhost:$MANAGEMENT_CONSOLE_PORT"

export JAVA_OPTS="-Djavax.net.ssl.trustStore=$JBOSS_HOME/standalone/configuration/jboss.keystore -Djavax.net.ssl.trustStorePassword=`echo Y2hhbmdlaXQ= | base64 -d`"

JBOSS_STATUS=`$JBOSS_CLI --commands=":read-attribute(name=server-state)" | grep result | awk '{print $3}' | sed 's/"//g'`
echo $JBOSS_STATUS

function wait_for_server_start() {
        until [ x`$JBOSS_CLI --commands=":read-attribute(name=server-state)" | grep result | awk '{print $3}' | sed 's/"//g'` == xrunning ]; do
        sleep 15
        done
}

#wait_for_server_start

#bouncycastle configuration

echo "=> Executing the commands"

$JBOSS_CLI -c << EOF
batch
:read-resource

module add --name=org.bouncycastle --resources=/app/jboss-eap/modules/system/layers/base/org/bouncycastle/main/bcprov-jdk18on-1.76.jar --dependencies=java.base,javax.api,javax.mail.api,javax.activation.api

module add --name=com.mysql --resources=/app/jboss-eap/modules/system/layers/base/com/mysql/mysql-connector-j-9.3.0.jar --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=mysql:add(driver-module-name=com.mysql,driver-name=mysql,driver-xa-datasource-class-name=com.mysql.cj.jdbc.MysqlXADataSource)
/subsystem=datasources/data-source="\$\{env.DS_NAME\}":add(jndi-name="\${env.JNDI_NAME:java:/default1}",connection-url="\${env.DS_CONNECTION_URL}",driver-name="mysql",user-name="\${env.DS_USER:default}",password="\${env.DS_PASSWORD:default}",enabled="true",use-ccm=false,use-java-context="true", statistics-enabled="true", min-pool-size="\${env.MIN_POOL_SIZE:0}",max-pool-size="\${env.MAX_POOL_SIZE:10}",check-valid-connection-sql="select 1 from dual",validate-on-match=true,background-validation=false,idle-timeout-minutes=3,prepared-statements-cache-size=0)

run-batch
EOF

echo "=> Shutting down JBOSS"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi

#export JAVA_OPTS=""

sed -i 's/<http-interface security-realm="ManagementRealm">/<http-interface ssl-context="sslcontext" security-realm="ManagementRealm">/g' $JBOSS_HOME/standalone/configuration/$JBOSS_CONFIG

rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current
#mv /app/dep/* $JBOSS_HOME/standalone/deployments/

#echo "=> Restarting JBOSS"
#$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -bmanagement 0.0.0.0 -c $JBOSS_CONFIG

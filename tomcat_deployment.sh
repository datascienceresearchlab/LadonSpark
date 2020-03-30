wget https://apache.brunneis.com/tomcat/tomcat-8/v8.5.51/bin/apache-tomcat-8.5.51.tar.gz

tar -xvf apache-tomcat-8.5.51.tar.gz

sudo mv apache-tomcat-8.5.51 /opt/tomcat

sudo chown $USER /opt/tomcat


export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
export CATALINA_PID=/opt/tomcat/temp/tomcat.pid
export CATALINA_HOME=/opt/tomcat
export CATALINA_BASE=/opt/tomcat
export 'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
export 'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'



wget https://github.com/datascienceresearchlab/LadonSpark/releases/download/v1.1/LadonSpark.war
mv LadonSpark.war $CATALINA_HOME/webapps/LadonSpark
/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.s
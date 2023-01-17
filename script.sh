PACKAGE_NAME=https://github.com/apache/tomcat.git
PACKAGE_VERSION=${1:-v11.0.0-M1}
PACKAGE_URL=https://github.com/apache/tomcat.git
cd ${HOME}
yum update -y
TOMCAT_VERSION="11.0.0"
yum install -y git wget
yum install -y java-11-openjdk-devel
wget http://mirror.downloadvn.com/apache/ant/binaries/apache-ant-1.10.12-bin.tar.gz
tar -xf apache-ant-1.10.12-bin.tar.gz
export ANT_HOME=${HOME}/apache-ant-1.10.12/
export PATH=${PATH}:${ANT_HOME}/bin
git clone https://github.com/apache/tomcat.git
cd tomcat
git checkout 11.0.0-M1
yes | cp build.properties.default build.properties
echo >> build.properties
echo "skip.installer=true" >> build.properties
ant release
export CATALINA_HOME=${HOME}/tomcat/output/dist
export PATH=${HOME}/tomcat/output/dist/bin:${PATH}
catalina.sh start &
catalina.sh run &

sleep 30

netstat -tulnp | grep 8005
netstat -tulnp | grep 8080

curl localhost:8080
curl localhost:8005

catalina.sh stop

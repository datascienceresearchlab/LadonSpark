#!/bin/bash
sudo chown -R $USER /opt/hadoop/
export JAVA_HOME=/usr/lib/jvm/java-$2-openjdk-amd64 >>/home/$USER/.bashrc
echo export HADOOP_HOME=/usr/local/hadoop >>/home/$USER/.bashrc
echo export PATH=$PATH:$HADOOP_HOME/bin >>/home/$USER/.bashrc
echo export PATH=$PATH:$HADOOP_HOME/sbin >>/home/$USER/.bashrc
echo export HADOOP_MAPRED_HOME=${HADOOP_HOME} >>/home/$USER/.bashrc
echo export HADOOP_COMMON_HOME=${HADOOP_HOME} >>/home/$USER/.bashrc
echo export HADOOP_HDFS_HOME=${HADOOP_HOME} >>/home/$USER/.bashrc
echo export YARN_HOME=${HADOOP_HOME} >>/home/$USER/.bashrc
source /home/$USER/.bashrc

echo "net.ipv6.conf.all.disable_ipv6 = 1" >>/etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1">>/etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1">>/etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1">>/etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1">>/etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1">>/etc/sysctl.conf


echo "<?xml version='1.0'?>"> /opt/hadoop/etc/hadoop/core-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<configuration>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "<property>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "<name>fs.default.name</name>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "<value>hdfs://$1:8020</value>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "<description>Nombre del filesystem por defecto.</description>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "</property>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "</configuration>">> /opt/hadoop/etc/hadoop/core-site.xml

echo "<?xml version='1.0'?>"> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<configuration>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<name>dfs.replication</name>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<value>20</value>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<description>Default block replication</description>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</property>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<property>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<name>dfs.namenode.name.dir</name>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<value>file:/usr/local/hadoop/hadoop_data/hdfs/namenode</value>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</property>">> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</configuration>">> /opt/hadoop/etc/hadoop/hdfs-site.xml

echo "<?xml version='1.0'?>"> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<configuration>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<property>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<name>mapreduce.framework.name</name>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<value>yarn</value>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<description>Execution framework</description>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "</property>">> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "</configuration>">> /opt/hadoop/etc/hadoop/mapred-site.xml

echo export JAVA_HOME=/usr/lib/jvm/java-$2-openjdk-amd64>>/opt/hadoop/etc/hadoop/hadoop-env.sh

chown -R $USER /opt/hadoop/
echo "Now the system need to reboot and continius with second script 'Hadoop_Setting2'..."
sleep 5
reboot


#!/bin/bash
sudo chown -R $USER /opt/hadoop/
echo "export JAVA_HOME=/usr/lib/jvm/java-$2-openjdk-amd64" >> /home/$USER/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> /home/$USER/.bashrc
echo "export PATH=$PATH:$HADOOP_HOME/bin" >> /home/$USER/.bashrc
echo "export PATH=$PATH:$HADOOP_HOME/sbin" >> /home/$USER/.bashrc
echo "export HADOOP_MAPRED_HOME=${HADOOP_HOME}" >> /home/$USER/.bashrc
echo "export HADOOP_COMMON_HOME=${HADOOP_HOME}" >> /home/$USER/.bashrc
echo "export HADOOP_HDFS_HOME=${HADOOP_HOME}" >> /home/$USER/.bashrc
echo "export YARN_HOME=${HADOOP_HOME}" >> /home/$USER/.bashrc
source /home/$USER/.bashrc

export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=${HADOOP_HOME}
export HADOOP_COMMON_HOME=${HADOOP_HOME}
export HADOOP_HDFS_HOME=${HADOOP_HOME}
export YARN_HOME=${HADOOP_HOME}

mkdir -p /op/hadoop/dfs/namenode
mkdir -p /op/hadoop/dfs/datanode

echo "<?xml version='1.0'?>" > /opt/hadoop/etc/hadoop/core-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<name>fs.default.name</name>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<value>hdfs://$1:8020</value>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "<description>Nombre del filesystem por defecto.</description>">> /opt/hadoop/etc/hadoop/core-site.xml
echo "</property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml

echo "<?xml version='1.0'?>" > /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<name>dfs.replication</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<value>3</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<description>Default block replication</description>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<name>dfs.namenode.name.dir</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<value>file:/opt/hadoop/dfs/namenode</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<name>dfs.dataenode.name.dir</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<value>file:/opt/hadoop/dfs/datanode</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml

echo "<?xml version='1.0'?>" > /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<?xml-stylesheet type='text/xsl' href='configuration.xsl'?>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<property>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<name>mapreduce.framework.name</name>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<value>yarn</value>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "<description>Execution framework</description>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "</property>" >> /opt/hadoop/etc/hadoop/mapred-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/mapred-site.xml

echo "export JAVA_HOME=/usr/lib/jvm/java-$2-openjdk-amd64" >> /opt/hadoop/etc/hadoop/hadoop-env.sh


echo "export JAVA_HOME=/usr/lib/jvm/java-$2-openjdk-amd64" >> /opt/hadoop/etc/hadoop/hadoop-env.sh




#!/bin/bash
$HADOOP_HOME/bin/hadoop namenode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/bin/hadoop fs -mkdir /user
$HADOOP_HOME/bin/hadoop fs -mkdir /user/input
echo "this proccess has finished, please upload file with upfile.sh, remember need to be in folder sparkDataSet and the name of file who parameter."

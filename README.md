Introduction
============
The LadonSpark tool offers an open-source and non-commercial solution to automatically configure and deploy a Spark cluster. Besides, the main advantage that a potential user acquires when he installs this system is to avoid the necessity to collaborate with an administrator role. Therefore, any user that have several machines connected by a network can configure and deploy a Spark cluster in a user-friendly, and free of charge way without any system administrator capabilities. Note that this fact means a great advantage, for instance, for small-medium data science research groups, as well as another more kind of users. The application has also been designed to easily integrate new algorithms by just uploading executable files and configuring the inputs. As a sample usage, the tool incorporates some algorithms of the machine learning library (MLlib) of Spark, in particular, Kmeans (clustering), Generalized linear models (regression), and FP-Growth (pattern extraction).

[Complete LadonSpark manual](/doc/User_guide)

Pre-requisites
==============

This section describes the prerequisites needed for the proper functioning of the proposed approach. In particular, the minimal prerequisites for the cluster launching can be summarized as follows:

1.  Shared dataset. The dataset to be processed by an algorithm has to be shared for all nodes of the cluster. Currently, there are two different ways to share it:

    1.  HDFS System. This system distributes a dataset in all nodes of the cluster. The LadonSpark application integrates the HDFS, which can be started up using a script that has been developed to install it across the cluster easily.

    2.  File repository. The dataset is replicated in every node at a specific folder. That way, Spark can access to the required specific data blocks in every node. This option reduces the computational time, but it requires much space in memory for each node.

2.  RSA ring. RSA keys are necessary for the exchange of information between nodes without having to enter credentials for each connection.

3.  Global user. It is necessary to facilitate the RSA ring. Hence, access to the path of the files is greatly simplified through the same user and password for all nodes.

4.  Nmap. This is a critical prerequisite because this application sniffs the network and creates the nodes list. Nmap must be installed in the master node, enabling it to discover new potential nodes to be part of the cluster.

5.  Spark package. This package must be downloaded and unzipped in the specific path */home/username*.

6.  Scala package. As happens with the Spark package, the Scala package must be downloaded and unzipped for the proper execution of an algorithm, which has been developed in the Scala programming language.

Finally, two new libraries have been included in the last update of the LadonSpark, and therefore, their installation will be required to execute an algorithm in both R or Python languages supported by Spark.

1.  R-base. This library allows executing R code from Spark. This language has been included because it is one of the most used languages for data analysis currently.

2.  Python. This language is a pervasive and popular programming language nowadays. For that reason, this library has been included in developing algorithms using Python from Spark.


Installation guide {#install}
==================

This section defines the process of configuring and installing the tools required for Ladon Spark. To begin with, we have to configure the IP of each node to be fixed so that we know for sure that IP has each of the nodes. We must also have a common username and password for each node. To complete the first part of the installation, download the Hadoop and spark fonts and place them in a path.

You can download the sources from the following website:

-   Apache Hadoop: https://archive.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz

-   Apache Spark: https://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz

To help in this part you can rely on the following commands:

-   Apache Spark: Assuming that the downloads have been made in the Downloads folder.

    1.  tar -xvf /home/$USER/Downloads/spark-2.3.1-bin-hadoop2.7.tgz

    2.  mv /home/$USER/Downloads/spark-2.3.1-bin-hadoop2.7 /home/$USER/spark

-   Apache Hadoop: Assuming that the downloads have been made in the Downloads folder.

    1.  tar -xvf /home/$USER/Downloads/hadoop-2.7.6.tar.gz

    2.  sudo mv /home/$USER/Downloads/hadoop-2.7.6 /opt/hadoop

MYSQL Configuration
-------------------

The configuration of MYSQL is done through the file ladonspark.sql, which generates the user and database necessary for the operation of the system. Depending on the installation mode, we will launch the SQL files using the command line interface or the PHPMYADMIN management web.
E.g.: mysql -uroot -p < ladonspark.sql

Master and Hadoop configuration
-------------------------------

In the package folder, the master.sh script can be found. The master.sh installs the source package necessary to correct work. The next command should write in the terminal.

1.  chmod +x master.sh

2.  ./master.sh

You can also find the script Hadoop_Setting.sh. With this script, we configure the Hadoop system to create an HDFS system with which to share the data sets. In the same way, you need the master’s IP address for the correct one installation and the version of java, please note that only we need the version number of java, we will use the following command.

1.  chmod +x Hadoop_Setting.sh

2.  ./Hadoop_Setting.sh 192.168.10 8

Slaves and Hadoop configuration
-------------------------------

The slave nodes are all nodes to use in a cluster that is different from the master node. The script file should be launch is slave.sh. This script configures the necessary folders for the correct functioning of the application by the slave node. You need a parameter that is the master’s IP address.

1.  chmod +x slave.sh

2.  ./slave.sh 192.168.1.10

We can also need to configure Hadoop in the slaves. With the Hadoop_Setting.sh, we configure the Hadoop system to create an HDFS system with which to share the data sets. In the same way, you need the master’s IP address for the correct one installation and the version of java, please note that only we need the version number of Java, we will use the following command.

1.  chmod +x Hadoop_Setting.sh

2.  Hadoop_Setting.sh 192.168.156 8

Starting Hadoop process
-----------------------

To complete the installation process, we must run the last script that deploys the Hadoop services and configures the HDFS services.

**Hadoop_setting2.sh**: This script is in charge of configuring the HDFS to support the file transfer, just run, and you’re done.

1.  chmod +x Hadoop_setting2.sh

2.  ./Hadoop_setting2.sh

In addition to the HDFS services, it is also included to facilitate the upload of data sets to the HDFS system.

We must copy the upfile.sh script in the folder where the datasets are located.

**upfile.sh**: A script in charge of uploading files to HDFS, for them we pass as parameter the file name along with the path.

1.  chmod +x upfile.sh

2.  ./upfile.sh /home/$USER/dataset/dataset.csv

Tomcat deployment
-----------------

As LadonSpark is a web application we neet to deploy it in an application server. To do that, we need to install Tomcat 8. Inside the resources, we can find an script that automatize the LadonSpark deployment.

1.  chmod +x tomcat_deployment.sh

2.  ./tomcat_deployment.sh username password ladonSpark_Path


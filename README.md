# LadonSpark
Introduction
============

This work introduces a web application, called LadonSpark, specifically
designed for an easy and efficient management of a Spark cluster. In
particular, an application with a friendly graphical user interface has
been developed to automatizes the deploying of a cluster and to start up
the distributed file system of Hadoop easily. Moreover, another relevant
functionality is the possibility of integrating any algorithm into the
web application. That is, the user only needs to provide the executable
file and the number of required inputs for a proper parametrization.
Source codes developed in Scala, R, Python or Java can be supported on
LadonSpark. In addition, clustering, regression, classification and
association rules algorithms are already integrated so that users can
test its usability from its early installation.

For a proper cluster management, Spark can make use of Apache's own
managers like Hadoop YARN o Mesos, or even it can make use of the native
Spark manager (Standalone). As for the distributed data storage, several
implementations can be used as NoSQL databases (Cassandra, MongoDB, or
HBase for example) or a cloud storage service (Amazon S3 or Microsoft
Azure, among other). Hadoop Distributed File System (HDFS) is a
distributed, scalable and portable file system that may store huge
files, typically in ranges of GB to TB (even PB), across multiple
machines. It can achieve reliability by replicating the cross multiple
hosts, and therefore, does not require any range storage on hosts.

However, to the author's knowledge, there is no a friendly application
able to easily deploy and parameterize a Spark cluster as well as a
distributed file system. Thus, the main goal is the development of a web
application that, by just few clicks and a graphical user interface,
fully deploys and configure a Spark cluster with HDFS. That is, it aims
at automating the cluster deploying thus avoiding a complex and tedious
manual configuration. Only the Databricks private company has a similar
framework to that proposed in this work. However, although it allows the
cluster management with different settings (<https://databricks.com>),
the users can not control physical resources and it is not for free.

The web application has also been designed in order to easily integrate
new algorithms by just uploading executable files and configuring the
inputs. Therefore, the deployment of the cluster itself is not the only
functionality, but also the integration of any big data algorithm that
needs to be executed across the nodes of the deployed cluster. A
repository for applications developed in Scala, R, Python or Java is
also maintained. As a sample usage, the tool incorporates some
algorithms of the machine learning library (MLlib) of Spark. In
particular, representative methods of clustering, regression,
classification and association rules have been integrated such as
k-Means, generalized linear models and FP-Growth, respectively.

Pre-requisites
==============

This section describes the prerequisites needed for a proper functioning
of the proposed approach. In particular, the minimal prerequisites for
the cluster launching can be summarized as follows:

1.  Shared dataset. The dataset to be processed by an algorithm has to
    be shared for all nodes of the cluster. Currently, there are two
    different ways to share it:

    1.  HDFS System. This system distributes a dataset in all nodes of
        the cluster. The LadonSpark application integrates the HDFS,
        which can be started up by means of a script that has been
        developed to easily install it across the cluster.

    2.  File repository. The dataset is replicated in every node at a
        specific folder. That way, Spark can access to the required
        specific data blocks in every node. This option reduces the
        computational time, but it requires much space in memory for
        each node.

2.  RSA ring. RSA keys are necessary for the exchange of information
    between nodes without having to enter credentials for each
    connection.

3.  Global user. It is necessary to facilitate the RSA ring. Hence, the
    access to the path of the files is greatly simplified through a same
    user and password for all nodes.

4.  Nmap. This is a critical prerequisite, because this application
    sniffs the network and creates the nodes list. Nmap must be
    installed in the master node, enabling it to discover new potential
    nodes to be part of the cluster.

5.  Spark package. This package must be downloaded and unzipped in the
    specific path */home/username*.

6.  Scala package. As happening with the Spark package, the Scala
    package must be downloaded and unzipped for a proper execution of
    any algorithm, which has been developed in the Scala programming
    language.

Finally, two new libraries have been included on the last update of the
LadonSpark, and therefore, their installation will be required to
execute an algorithm in both R or Python languages supported by Spark.

1.  R-base. This library allows executing R code from Spark. This
    language has been included because it is one of the most used
    languages for data analysis currently.

2.  Python. This language is a very widespread and popular programming
    language nowadays. For that reason, this library has been included
    to develop algorithms using Python from Spark.

Obtaining the resources
=======================

There are two ways to getting the application resources:

1.  From GitHub: <https://github.com/datascienceresearchlab/LadonSpark>

Installation process {#install}
====================

This section defines the process of configuring and installing the tools
required for Ladon Spark.

To begin with we have to configure the IP of each node to be fixed so
that we know for sure that IP has each of the nodes. We must also have a
common username and password for each node.

To complete the first part of the installation, download the Hadoop and
spark fonts and place them in a path. You can download the sources from
the following website:

-   Apache Hadoop:
    https://archive.apache.org/dist/hadoop/common/hadoop-2.7.6/hadoop-2.7.6.tar.gz

-   Apache Spark:
    https://archive.apache.org/dist/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz

To help in this part you can rely on the following commands:

-   Apache Spark: Assuming that the downloads have been made in the
    Downloads folder.

    1.  tar -xvf /home/\$USER/Downloads/spark-2.3.1-bin-hadoop2.7.tgz

    2.  mv /home/\$USER/Downloads/spark-2.3.1-bin-hadoop2.7
        /home/\$USER/spark

-   Apache Hadoop: Assuming that the downloads have been made in the
    Downloads folder.

    1.  tar -xvf /home/\$USER/Downloads/hadoop-2.7.6.tar.gz

    2.  sudo mv /home/\$USER/Downloads/hadoop-2.7.6 /opt/hadoop

MYSQL Configuration
-------------------

The configuration of MYSQL is done through the file ladonspark.sql,
which generates the user and database necessary for the operation of the
system.

Depending on the installation mode, we will launch the SQL files using
the command line interface or the PHPMYADMIN management web.

E.g.: mysql -uroot -p \< ladonspark.sql

Master node
-----------

The master node is the most important. In the package folder, the
master.sh script can be found. the master.sh install the source package
neecesary to correct work. The next command should write in the
terminal.

1.  chmod +x master.sh

2.  ./master.sh

**Hadoop\_Setting.sh**: With this script, we will configure the hadoop
system to create a HDFS system with which to share the data sets. In the
same way, you need the master's IP address for the correct one
installation and the version of java, please note that only we need the
version number of java, we will use the following command.

1.  chmod +x Hadoop\_Setting.sh

2.  Hadoop\_Setting.sh 192.168.10 8

Slave node
----------

The slaves nodes are all nodes to use in cluster that is different to
master node. The script file should be launch is slave.sh.

**slave.sh**: This script configures the necessary folders for the
correct functioning of the application by the slave node. You need a
parameter that is the master's IP address.

1.  chmod +x slave.sh

2.  ./slave.sh 192.168.1.10

**Hadoop\_Setting.sh**: With this script, we will configure the Hadoop
system to create a HDFS system with which to share the data sets. In the
same way, you need the master's IP address for the correct one
installation and the version of java, please note that only we need the
version number of Java, we will use the following command.

1.  chmod +x Hadoop\_Setting.sh

2.  Hadoop\_Setting.sh 192.168.156 8

Starting Hadoop procces
-----------------------

To complete the installation section we must run the last script that
deploys the hadoop services and configures the HDFS services.

**Hadoop\_setting2.sh**: This script is in charge of configuring the
HDFS to support the file transfer, just run and you're done.

1.  chmod +x Hadoop\_setting2.sh

2.  ./Hadoop\_setting2.sh

In addition to the HDFS services, it is also included to facilitate the
upload of data sets to the HDFS system.

We must copy the upfile.sh script in the folder where the datasets are
located.

**upfile.sh**: Script in charge of uploading files to HDFS, for them we
pass as parameter the file name along with the path.

1.  chmod +x upfile.sh

2.  ./upfile.sh /home/\$USER/dataset/dataset.csv

Tomcat deployment
-----------------

Para desplegar LadonSpark es necesario disponer de un contenedor de
servelt en este caso se procede a instalar Tomcat 8.

Dentro del proyecto se adjunta un Script para orchestar el despliegue
facilitando de esta forma la instalación.

1.  chmod +x tomcat\_deployment.sh

2.  ./tomcat\_deployment.sh username password ladomsparl\_Path

Use cases
=========

In this section we describe in a simple way, the functionalities of
LADON SPARK.

We assume that the installation manual has been completed and Ladon
Spark is working properly, otherwise go to the Section
[4](#install){reference-type="ref" reference="install"} and complete the
installation.

Home page
---------

This is the main page of the application where information about the
website and the developer is displayed.

![Home page](captures/home.png){#fig:home}

Cluster settings
----------------

To access the communications section, we can do so from the menu by
clicking on the communications option. In this section I would start
with the cluster management functionality.

![Cluster page.](captures/setcluster.png){#fig:cluster}

As we can see in the Figure [2](#fig:cluster){reference-type="ref"
reference="fig:cluster"}. On the right, we find a text box with the
description of each field. On the left the form is defined below.

-   The network mask: In this field, we must introduce the network in
    the one that will find the nodes that will form the cluster. An
    example:

    -   192.168.1.0/24

    -   193.147.187.63/26

-   System user: We enter the user name they must have in common all
    nodes of the system.

-   Network interface: the name of the network interface with which we
    connect to the network. An example:

    -   wlan0

    -   eth0

    -   eno1

![Cluster page.](captures/settCluster1.png){#fig:cluster01}

When you have entered all the data in the fields as shown in the Figure
[3](#fig:cluster01){reference-type="ref" reference="fig:cluster01"},
click on the Send button.

### All hosts in the network

In the user interface all the nodes that exist in the network are
displayed, you should check that the master node appears.

![All host in the network
page.](captures/settCluster2.png){#fig:cluster02}

In the Figure [4](#fig:cluster02){reference-type="ref"
reference="fig:cluster02"}, an example is shown with the network
192.168.1.0.0/24, where we can select the nodes that want to participate
in a cluster through a checkbox. We can also click on the Select all
button, which will mark all the nodes. Once you have selected the nodes
you want, click on the Select button.

### Selected hosts

This section is the last step before the cluster is deployed, in which
we can see the hosts selected in the previous step, and a check box,
which displays a small form that we will describe below.

![Hosts Selected page.](captures/settCluster3.png){#fig:cluster03}

This form is the parameterization of the Spark configuration file, the
form is composed of the three main parameters of Spark.

-   **Cores**: Number of cores that we will use for each node.

-   **RAM memory**: 1024 MB.

-   **Instance number**: 1.

If the \"Advanced configuration\" option is not selected, the cluster
will have the default Spark configuration:

-   **Cores**: 1.

-   **RAM memory**: RAM memory to be used per node.

-   **Instance number**: Number of instances that will be launched for
    each node.

Once this process is completed, you are redirected to the algorithms
section. The menu undergoes a small modification: a button is added to
turn off the cluster.

Algorithm
---------

This section is composed of two parts, but first we will comment on the
main interface of the algorithms section.

![Algorithm page.](captures/alg1.png){#fig:algo}

In the Figure [6](#fig:algo){reference-type="ref" reference="fig:algo"}
we can see the division of the interface into two parts, the left part
is used to launch an algorithm and the right part leads us to the
section of adding an algorithm.

### Add new Algorithm

This subsection, we can add algorithms to the system by means of a form,
which appears on the left side of the interface, and on the right side,
we will have a small description of the fields of the form.

![Add algorithm page.](captures/alg2.png){#fig:algo2}

As shown in the Figure [7](#fig:algo2){reference-type="ref"
reference="fig:algo2"}, the form for adding algorithm is simple.

-   **Name of the Algortihm**: This field is for naming our algorithm.

-   **Main Class**: We must indicate which is the main class of the
    algorithm.

-   **Select binary file**: This field is for including the \"jar\" file
    with the source packages of the algorithm.

-   **Number of parameters**: When we write the number of parameters, we
    will create the Insert name and type\" fields, since here we
    indicate the number of parameters that has our algorithm.

-   **Name and type**: As its own name indicates, we must enter the name
    of the parameter and the type of data it uses.

### Launch algorithm

First we must select an algorithm from the list to auto-generate the
fields. As shown in Figure [6](#fig:algo){reference-type="ref"
reference="fig:algo"}, left section.

-   Field select: Algorithms that we have stored in the system, which
    generate the parameterization fields of the system.

-   Dataset path: Name of the dataSet containing the data we are going
    to work with.

Finally, click on the Selec button to execute the algorithm. When the
algorithm is finished, the system redirects to a last interface where
the results are displayed.

Contact
=======

![image](./img/upo_logo){width="5.7cm"}
![image](./img/upolab_logo){width="5.7cm"}\
[ ]{style="color: blue"}

  ---------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------
  Antonio M. Fernández-Gómez Email: **amfergom\@alu.upo.es** Web: **datalab.upo.es/fernandez**   David Gutiérrez-Avilés Email: **dgutavi\@upo.es** Web: **datalab.upo.es/gutierrez**
  Alicia Troncoso Email: **atrolor\@upo.es** Web: **datalab.upo.es/troncoso**                    Francisco Martínez-Álvarez Email: **fmaralv\@upo.es** Web: **datalab.upo.es/martinez**
  ---------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------

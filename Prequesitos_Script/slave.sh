#!/bin/bash
if [ ! -d  /home/$USER/spark ]
then
	cd /home/$USER
	echo "you have to download, decompress and rename the apache spark fonts, inside the user's root folder."
        echo "The spark route should be: /home/$USER/spark"
	sudo apt-get install scala
	sudo apt-get install python
	sudo apt-get install r-base
	sudo apt-get install openssh-server
else
	sudo apt-get install scala
	sudo apt-get install python
	sudo apt-get install r-base
	sudo apt-get install openssh-server		
fi

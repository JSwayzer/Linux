#!/bin/sh
for name in `cat onepiece_name`
do
echo $name
useradd -m -d /home/$name -s /bin/bash $name
done

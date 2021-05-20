#!/bin/sh
for name in `cat onepiece_name`
do
	echo alterando senha do $name
	passwd $name
	echo toor\n
	echo toor\n
echo; echo "$name’s password changed!"
done

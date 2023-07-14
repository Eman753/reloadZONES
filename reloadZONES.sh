#!/bin/bash

# Script d'automatisation pour recharger complètement une zone DNS sur un DNS secondaire

if ! [ $# -eq 1 ]
then
	echo "Veuillez entrer le nom d'un fichier de zone"
	exit 1
elif [ -f /var/cache/bind/$1 ]
then
	echo "Suppression du fichier de zone"
	rm /var/cache/bind/$1
	if ! [ $? -eq 0 ]
	then
		echo "La suppression a echoué, arrêt du programme"
		exit 1
	fi
	echo "Redémarrage de BIND9"
	systemctl restart bind9
	if ! [ $? -eq 0 ]
	then
		echo "Echec lors du redémarrage de BIND9"
		exit 1
	fi
else
	echo "Le fichier de zone n'existe pas. Arrêt du programme"
	exit 1
fi

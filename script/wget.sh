#!/bin/sh
## wget.sh for  in /u/a1/berard_a/script
##
## Made by axel berardino
## Login   <berard_a@epita.fr>
##
## Started on  Mon Oct  9 21:18:59 2006 axel berardino
## Last update Mon Oct  9 21:28:54 2006 axel berardino
##

# Lis le mot de passe dans le fichier ~/.socks (chmod 400)
pass=`cat ~/.socks`

# Serveur epita
wget --proxy-user=$USER --proxy-passwd=$pass $1

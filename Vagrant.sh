#!/usr/bin/env bash

case $1 in
  up )
    vagrant up --provision
    ;;
  rebuild )
    vagrant destroy -f
    vagrant up --provision
    ;;
  down )
    vagrant destroy -f
    ;;
  * )
    echo "Usage: up|rebuild|down"
esac

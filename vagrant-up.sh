#!/usr/bin/env bash

case $1 in
  create )
    vagrant up --no-provision
    vagrant snapshot save init
    vagrant provision
    ;;
  restore )
    vagrant snapshot restore init
    vagrant provision
    ;;
  destroy )
    vagrant destroy -f
    ;;
  * )
    Usage: create|restore|destroy
    ;;
esac

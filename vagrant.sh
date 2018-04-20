#!/usr/bin/env bash

function create() {
  vagrant up --no-provision
  vagrant halt
  vagrant snapshot save init
  vagrant up --provision
}

case $1 in
  up )
    create
    ;;
  restore )
    vagrant snapshot restore init
    vagrant up --provision
    ;;
  rebuild )
    vagrant destroy -f
    create
    ;;
  * )
    Usage: up|restore|rebuild|destroy
    ;;
esac

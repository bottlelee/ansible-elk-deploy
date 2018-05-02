#!/usr/bin/env bash

function create() {
  rm host_vars install_report -rf
  vagrant up --no-provision
  vagrant snapshot save init
  vagrant up --provision
}

case $1 in
  up )
    create
    ;;
  restore )
    vagrant snapshot restore init
    rm host_vars -rf
    vagrant up --provision
    ;;
  rebuild )
    vagrant destroy -f
    create
    ;;
  down )
    vagrant destroy -f
    rm host_vars install_report -rf
    ;;
  * )
    echo "Usage: up|restore|rebuild|down"
esac

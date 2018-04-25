#!/usr/bin/env bash

function create() {
  rm host_vars -rf
  vagrant up --no-provision
  # vagrant halt
  vagrant snapshot save init
  vagrant up --provision
}

case $1 in
  up )
    rm host_vars install_report -rf
    create
    ;;
  restore )
    vagrant snapshot restore init
    rm host_vars -rf
    vagrant up --provision
    ;;
  rebuild )
    vagrant destroy -f
    rm host_vars install_report -rf
    vagrant up
    ;;
  down )
    vagrant destroy -f
    rm host_vars -rf
    ;;
  * )
    echo "Usage: up|restore|rebuild|down"
esac

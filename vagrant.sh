#!/usr/bin/env bash

function create() {
  vagrant up --no-provision
  vagrant snapshot save init
  vagrant reload --provision
}

case $1 in
  up )
    create
    ;;
  restore )
    vagrant snapshot restore init
    # vagrant reload --provision
    ;;
  rebuild )
    vagrant destroy -f
    create
    ;;
  down )
    vagrant destroy -f
    ;;
  * )
    echo "Usage: up|restore|rebuild|down"
esac

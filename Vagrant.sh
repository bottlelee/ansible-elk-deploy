#!/usr/bin/env bash

function create() {
  vagrant up --provision --install-provider
  # vagrant vbguest
  # vagrant reload --provision
}

case $1 in
  up )
    create
    ;;
  rebuild )
    vagrant destroy -f
    create
    ;;
  destroy )
    vagrant destroy -f
    ;;
  * )
    echo "Usage: $0 up|rebuild|destroy"
esac

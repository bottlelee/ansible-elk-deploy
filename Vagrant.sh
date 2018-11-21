#!/usr/bin/env bash

if [[ $3 ]]; then
  export VM_BOX=$3
  echo Seleted distro is ${VM_BOX}
fi

if [[ $2 == +([0-9]) ]]; then
  export ELK_INSTANCES=$2
  echo ${ELK_INSTANCES} virtual machine\(s\) will be boot up.
fi

function create() {
  vagrant up --provision --install-provider
  # if [[ $? == 0 ]]; then
  #   vagrant reload --provision
  # fi
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
    echo "
  Usage:
    $0 up         - Bootstrap virtual machines.
    $0 rebuild    - Destroy and bootstrap again.
    $0 destroy    - Shutdown and destroy all machines.
    "
esac

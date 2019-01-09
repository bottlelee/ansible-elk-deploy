#!/usr/bin/env bash
set -e

function get_pip {
  echo "--------------"
  echo "Installing pip"
  echo "--------------"
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py || wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py
  python /tmp/get-pip.py || python3 /tmp/get-pip.py
}

function get_ansible {
  echo "------------------"
  echo "Installing ansible"
  echo "------------------"
  pip install -i https://pypi.doubanio.com/simple ansible
}

if [[ $USER != "root" ]]; then
  echo "Current user is not 'root'."
  echo "Run 'sudo $0' to try again."
  exit 1
fi

if [[ ! -e "/tmp/get-pip.py" ]]; then
  get_pip
  get_ansible
else
  get_ansible
fi

ansible --version

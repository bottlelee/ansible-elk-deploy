#!/usr/bin/env bash

if [[ $USER != "root" ]]; then
  echo "Current user is not 'root'."
  echo "Run 'sudo -H $0'"
  exit 1
fi

cd /tmp

echo "Installing pip..."
wget -q https://bootstrap.pypa.io/get-pip.py -O get-pip.py || curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python /tmp/get-pip.py || python3 /tmp/get-pip.py

echo "Installing ansible..."
pip install -i https://pypi.doubanio.com/simple ansible

ansible --version

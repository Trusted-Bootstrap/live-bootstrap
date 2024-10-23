#!/usr/bin/env bash

git submodule update --init --recursive

([[ -d "./venv" ]] || python3 -m venv ./venv) && 
  source ./venv/bin/activate && 
  pip3 install -r requirenments.txt


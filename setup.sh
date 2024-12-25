#!/bin/bash

# setup utils-ubuntu project

# Create venv and install dependencies
python3 -m venv .venv
source .venv/bin/activate
pip install wheel
pip install -r requirements.txt
echo "Virtual environment created"
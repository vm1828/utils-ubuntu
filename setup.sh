#!/bin/bash

# Setup utils-ubuntu project

# Create venv and install dependencies
python3 -m venv .venv
source .venv/bin/activate
pip install wheel
pip install -r requirements.txt
echo "Virtual environment created"

# Add permissions for scripts
sudo chmod 700 INIT.sh
sudo find ./scripts -type f -name "*.sh" -exec chmod 700 {} \;

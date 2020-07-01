#!/bin/bash

# This is to make your life easier.
snapcraft clean
rm -r build dist *.snap *.egg-info
echo "Removing snakesnap..."
sudo snap remove snakesnap

#!/bin/bash

# Here's that command in a bash script
snapcraft clean && python3 setup.py bdist_wheel && snapcraft

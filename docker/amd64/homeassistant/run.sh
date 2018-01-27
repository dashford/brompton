#!/usr/bin/env bash

cd /ha-installation && cp --symbolic-link /config/* ./

python3.6 -m homeassistant --config /ha-installation

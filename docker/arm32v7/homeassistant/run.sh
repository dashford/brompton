#!/usr/bin/env bash

cd /ha-installation && cp -f --symbolic-link /config/* ./

python3.6 -m homeassistant --config /ha-installation

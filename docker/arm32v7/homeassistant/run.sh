#!/usr/bin/env bash

cd /ha-installation && cp -f --symbolic-link /config/* ./

python -m homeassistant --config /ha-installation

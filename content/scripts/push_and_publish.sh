#!/usr/bin/env bash

git add . 
git commit -m "$1"
./scripts/publish_prod.sh



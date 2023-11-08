#!/usr/bin/env bash

export YEAR=2023

cat scripts/templates/blog_template.md > src/blog/posts/$YEAR/$1.md
cat scripts/templates/blog_template.md > src/blog/posts/$YEAR/$1.excerpt.md
cat scripts/templates/blog_template.properties > src/blog/posts/$YEAR/$1.properties


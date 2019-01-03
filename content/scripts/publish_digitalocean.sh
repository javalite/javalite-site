#!/bin/sh
mvn clean install
rsync -rv --delete target/output/ 104.131.127.231:/opt/javalite/content




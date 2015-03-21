#!/bin/sh
mvn clean package
scp target/ROOT.war javalite@45.55.133.36:/tmp

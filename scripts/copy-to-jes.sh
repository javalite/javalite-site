#!/bin/sh
mvn clean package
scp target/ROOT.war 192.168.85.10:/tmp

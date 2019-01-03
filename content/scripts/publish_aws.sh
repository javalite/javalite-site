#!/bin/sh
mvn clean install
rsync -rv --delete target/output/ ec2-18-217-210-247.us-east-2.compute.amazonaws.com:/opt/javalite/content




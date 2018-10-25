#!/usr/bin/env bash
mvn clean install

scp ./target/ROOT.war ec2-18-217-210-247.us-east-2.compute.amazonaws.com:/opt/javalite/tomcat/webapps/

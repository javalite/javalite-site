#!/usr/bin/env bash
ssh ec2-18-217-210-247.us-east-2.compute.amazonaws.com "tail -f /opt/javalite/tomcat/logs/catalina.out"

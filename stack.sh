#!/bin/bash
							
							sudo yum -y install wget
							wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz
							sudo tar -zxvf apache-tomcat-8.0.33.tar.gz -C /opt/tomcat --strip-components=1
						         cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							cd /usr/share/tomcat/webapps
							cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							{

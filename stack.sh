#!/bin/bash
							
							 cat /var/spool/mail/root

							
							sudo yum -y install wget
							wget  http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz
							sudo tar -zxvf apache-tomcat-9.0.14.tar.gz -C /opt/tomcat --strip-components=1
						         cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							cd /usr/share/tomcat/webapps
							cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							{

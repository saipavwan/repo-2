#!/bin/bash
							
							sudo yum -y install wget
							sudo sed -i \"s#Defaults.*requiretty#Defaults\\!requiretty#g\" /etc/sudoers
							sudo yum install epel-release -y
							sudo yum install ansible -y
							sudo yum install git -y
							sudo mkdir /root/ansible
							cd /root/ansible
							sudo git clone https://github.com/saipavwan/deployment.git
              cd /root/ansible/deployment/tomcat
							sudo ansible-playbook site.yml
							cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							cd /usr/share/tomcat/webapps
							cd /usr/share/tomcat/bin
							./shutdown.sh
							./startup.sh
							{

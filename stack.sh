echo "------------------------executing script------------------------------"
echo
#timeout 20s curl -w '1_host_lookup:%{time_namelookup}\n1_host_connect:%{time_connect}\n1_page_load:%{time_total}\n' -o /dev/null -s "http://build.jenkins.columbiadevops.com/" >> /home/jenkins/dashboard/workspace/site_monitor_feed
#timeout 20s curl -w '2_host_lookup:%{time_namelookup}\n2_host_connect:%{time_connect}\n2_page_load:%{time_total}\n' -o /dev/null -s "http://jenkins.colmdev.com/" >> /home/jenkins/dashboard/workspace/site_monitor_feed
#timeout 20s curl -w '3_host_lookup:%{time_namelookup}\n3_host_connect:%{time_connect}\n3_page_load:%{time_total}\n' -o /dev/null -s "http://test.jenkins.columbiadevops.com/" >> /home/jenkins/dashboard/workspace/site_monitor_feed
timeout 20s curl -Is http://build.jenkins.columbiadevops.com/ | head -n 1 > /home/jenkins/dashboard/workspace/site_Build_jenkins_test
timeout 20s curl -Is http://jenkins.colmdev.com/ | head -n 1 > /home/jenkins/dashboard/workspace/site_X1_jenkins_test
timeout 20s curl -Is http://test.jenkins.columbiadevops.com/ | head -n 1 > /home/jenkins/dashboard/workspace/site_test_jenkins_test
#cd /home/jenkins/dashboard/workspace
#rm /home/jenkins/dashboard/workspace/sites-monitor.html
#cp /home/jenkins/dashboard/workspace/sites-monitor.html.tmpl /home/jenkins/dashboard/workspace/sites-monitor.html
now_date=`date +%m/%d-%H:%M:%S`
later_date=`date --date='5 minutes' +%m/%d-%H:%M:%S`
#sed -i "s|Status Updated on:|Status Updated on: `echo $now_date`|" /home/jenkins/dashboard/workspace/sites-monitor.html
#sed -i "s|Next Update at:|Next Update at: `echo $later_date`|" /home/jenkins/dashboard/workspace/sites-monitor.html
#Build Jenkins
if [[ `grep "200 OK" site_Build_jenkins_test` ]]
then
echo "checked the value for build jenkins"
#sed -i "s/1_yet_to_update/Build_UP/" /home/jenkins/dashboard/workspace/sites-monitor.html
else
echo "checked the value for X1 jenkkins"
sed -i "s/1_yet_to_update/Builld_DOWN/" /home/jenkins/dashboard/workspace/sites-monitor.html
#email here
echo "Build Jenkins was DOWN" | mailx -s "This Email will Trigger Automatically" -a /var/www/html/sites-monitor.html pavan.sai@columbia.com
fi
#X1 Jenkins
if [[ `grep "200 OK" site_X1_jenkins_test` ]]
then
sed -i "s/2_yet_to_update/X1_UP/" /home/jenkins/dashboard/workspace/sites-monitor.html
else
sed -i "s/2_yet_to_update/X1_DOWN/" /home/jenkins/dashboard/workspace/sites-monitor.html
#email here
echo "X1 Jenkins was DOWN" | mailx -s "This Email Will Trigger Automatically" -a /var/www/html/sites-monitor.html pavan.sai@columbia.com
fi
#Test Jenkins
if [[ `grep "200 OK" site_test_jenkins_test` ]]
then
sed -i "s/3_yet_to_update/Test_UP/" /home/jenkins/dashboard/workspace/sites-monitor.html
else
sed -i "s/3_yet_to_update/Test_DOWN/" /home/jenkins/dashboard/workspace/sites-monitor.html
#email here
echo "TEST Jenkins was DOWN" | mailx -s "This Email Will Trigger Automatically" -a /var/www/html/sites-monitor.html pavan.sai@columbia.com

fi
#Feed for Build Jenkins
for i in `cut -d':' -f1 /home/jenkins/dashboard/workspace/site_monitor_feed`
do
inplace="${i}"
replace=$(grep "$i" /home/jenkins/dashboard/workspace/site_monitor_feed|cut -d':' -f2)
sed -i "s|`echo $inplace`|`echo $replace`|" /home/jenkins/dashboard/workspace/sites-monitor.html
done
cp /home/jenkins/dashboard/workspace/sites-monitor.html /var/www/html/
chmod 777 /var/www/html/sites-monitor.html

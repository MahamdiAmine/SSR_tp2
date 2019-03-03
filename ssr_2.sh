#! /bin/bash

#============================================================================================================
#           Twitter:      https://twitter.com/mahamdi.amine
#           Github :      https://github.com/MahamdiAmine
#           Website:      https://mahamdiamine.github.io/
#============================================================================================================
yellow='\e[1;33m'
green='\e[0;34m'
BlueF='\e[1;34m'
Red="\e[1;31m"
Cclear="\e[0m"
dir=`pwd`
arg=$1
clear
#######################################################################################
bar ()
{
	echo -n  Initialisation = =;
	sleep 2 & while [ "$(ps a | awk '{print $1}' | grep $!)" ] ; do for X in '-' '\' '|' '/'; do echo -en "\b$X"; sleep 0.1; done; done
  echo
	echo
BAR='█║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║║█'

for i in {1..50}; do
    echo -ne "\r             ${BAR:0:$i}"
    sleep 0.04
done
}
################################# < Super User Check > ################################
if [ "$#" != "1" ]; then
	echo -e "${Red}       illegal number of parameters.$Cclear"
	echo
	exit 1
fi
################################### < XTerm Checks > ###################################
if [ ! "${DISPLAY:-}" ]; then
    echo -e "${CRed}The script should be exected inside a X (graphical) session.$CClr"
    echo
    exit 2
fi
########################################################################################
if [ " $arg " = ' init ' ] ; then
echo
echo -e $yellow" "
bar
echo -e
su -lc 'mkdir /var/www/html/selinux && chown -R fedora:fedora /var/www/html/selinux'
su -lc 'cp -f /home/fedora/Downloads/index.html /var/www/html/selinux/'
ls -alZ /var/www/html/selinux/
service httpd restart
echo -e $yellow"  [*] Done ."
########################################################################################
elif
[ " $arg " = ' create-prob ' ] ; then
echo -e $yellow "   Creating the problem ..."
cp /var/www/html/selinux/index.html /home/selinux.html 
mv /home/selinux.html /var/www/html/selinux/
ls -alZ /var/www/html/selinux/
echo -e $yellow"  [*] Done ."
sleep 1
########################################################################################
elif
[ " $arg " = ' fix-with-restorecon ' ] ; then
echo -e $yellow "   fixing the problem with restorecon ..."
su -lc 'restorecon -v /var/www/html/selinux/selinux.html'
echo -e $yellow"  [*] Done ."
sleep 1
########################################################################################
elif
[ " $arg " = ' fix-with-chcon ' ] ; then
echo -e $yellow "   fixing the problem with chcon ..."
su -lc 'chcon -t httpd_sys_content_t /var/www/html/selinux/selinux.html'
echo -e $yellow"  [*] Done ."
sleep 1
########################################################################################
elif
[ " $arg " = ' show-path ' ] ; then
matchpathcon /var/www/html/selinux/selinux.html
sleep 1
########################################################################################
elif
[ " $arg " = ' fix-with-semanage ' ] ; then
echo -e $yellow "   fixing the problem with csemanage ..."	
#semanage fcontext -a -t httpd_sys_content_t '/srv/web(/.*)?'
restorecon -R -v /srv/web
firefox --new-tab /var/www/html/selinux/selinux.html
echo -e $yellow"  [*] Done ."
sleep 1
########################################################################################
elif [ " $arg " = ' -h ' ] || [ " $arg " = ' --help ' ]; then
		echo ""
		echo "Options :"
		echo "init"		
		echo "create-prob"
		echo "fix-with-restorecon"
		echo "fix-with-chcon"
		echo "show-path"
		echo "fix-with-semanage"
		echo ""
	   else
		echo -e $green " use  ssr_2 -h for help "
fi


echo -e $Cclear

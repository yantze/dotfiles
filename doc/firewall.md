###firewall

####open a port permanent
firewall-cmd --zone=dmz --add-port=2888/tcp --permanent

#and then reload the firewall
firewall-cmd --reload

#but if is a known service, you can use:
firewall-cmd --zone=public --add-service=http --permanent

#advance
firewall-cmd --list-all
firewall-cmd --set-default-zone=<zone>.

You can check if the port has actually be opened by running:

firewall-cmd --zone=<zone> --query-port=80/tcp

firewall-cmd --zone=<zone> --query-service=http

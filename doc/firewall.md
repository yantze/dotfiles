###firewall

####open a port permanent
firewall-cmd --zone=dmz --add-port=2888/tcp --permanent

and then reload the firewall
firewall-cmd --reload

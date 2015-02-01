###firewall

####open a port permanent
    firewall-cmd --zone=dmz --add-port=2888/tcp --permanent

if is a known service, you can use:
    firewall-cmd --zone=public --add-service=http --permanent

and then reload the firewall
    firewall-cmd --reload

list add firewall rules:
    firewall-cmd --list-all

firewall-cmd --set-default-zone=<zone>:
    firewall-cmd --zone=<zone> --query-port=80/tcp

###go back to a more classic iptables setup
```bash
yum install iptables-services
systemctl mask firewalld
systemctl enable iptables
systemctl enable ip6tables
systemctl stop firewalld
systemctl start iptables
systemctl start ip6tables
```

Enable the service at boot-time:
    systemctl enable iptables
    systemctl enable ip6tables

Saving firewall rules:
    service iptables save
    or,/usr/libexec/iptables/iptables.init save

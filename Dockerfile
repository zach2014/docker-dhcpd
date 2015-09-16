# Pull lean base image.
FROM ubuntu:14.04 

# http proxy
ENV http_proxy http://10.41.255.9:80
ENV https_proxy https://10.41.255.9:80

#RUN apt-get install -y dnsmasq tcpdump
RUN apt-get -y update
RUN apt-get install -y isc-dhcp-server

# Install helpers
ADD dhcpd.conf.sample /etc/dhcp/dhcpd.conf
ADD dhcpd6.conf.sample /etc/dhcp/dhcpd6.conf
RUN touch /var/lib/dhcp/dhcpd6.leases

ADD pipework /usr/bin/pipework
#ADD entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]

CMD \
    pipework --wait -i eth1  && \
    dhcpd -6 eth1 -cf /etc/dhcp/dhcpd6.conf -lf /var/lib/dhcp/dhcpd6.leases && \ 
    dhcpd -f eth1 -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases  

# Expose ports, exposing the port is pointeless since the dhcpd server needs
# to run on the same subnet it's handing leases out on.
#EXPOSE 67/udp

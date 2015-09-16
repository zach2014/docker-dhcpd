lxc-dhcpd
============
Run DHCPD in a docker instance with ovs. refer to https://github.com/kmanna/docker-dhcpd and update to support IPv6.

Build Docker Image
------------------

    $ cp dhcpd.conf.sample dhcpd.conf
    $ cp dhcpd6.conf.sample dhcpd6.conf
    $ docker build -t=dhcpd .


Run/Stop Docker Image
------------------
    $ sudo ./run lxc-dhcpd ovs-bridge-name  20.15.9.2/24 20:15:9::2/64
    $ sudo ./stop lxc-dhcpd ovs-bridge-name

Check dhcpd inside container
----------------------------
    $ docker exec lxc-dhcpd ifconfig eth1
    $ docker exec lxc-dhcpd ps
    $ docker exec lxc-dhcpd netstat -ln
    
Scripts and tools
----------------------------
 1. pipework from https://github.com/jpetazzo/pipework, update to support "ip -6" necessary extensions. 
 2. ovs-docker from https://github.com/openvswitch/ovs/blob/master/utilities/ovs-docker, extend to support "ip -6" also.

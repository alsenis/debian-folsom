#!/bin/bash

#################
# CINDER
################
# temporary fix
sed -i 's/"//g' /etc/cinder/api-paste.ini


#################
# TGT
################

# add tgt target
echo "include /var/lib/cinder/volumes/*" >> /etc/tgt/targets.conf

# start daemon
/usr/sbin/tgtd

# create service for daemon

cp /etc/init.d/skeleton /etc/init.d/tgtd
sed -i "s/^NAME=.*/NAME=tgtd/g" /etc/init.d/tgtd
sed -i "s/^DESC=.*/DESC='Linux SCSI target framework'/g" /etc/init.d/tgtd
sed -i "s/^DAEMON_ARGS=.*/DAEMON_ARGS=''/g" /etc/init.d/tgtd
chmod +x /etc/init.d/tgtd
chkconfig --add tgtd


#######################
# nova.conf
#######################

# remove osapi_volume from api
sed -i "s/ec2,osapi_compute,metadata,osapi_volume/ec2,osapi_compute,metadata/g" /etc/nova/nova.conf

# commented all quantum section
sed -i "s/^network_api_class = nova.network.quantumv2.api.API/#network_api_class = nova.network.quantumv2.api.API/g" /etc/nova/nova.conf
sed -i "s/^quantum_/#quantum_/g" /etc/nova/nova.conf
sed -i "s/^libvirt_vif_driver = nova.virt.libvirt.vif.LibvirtHybirdOVSBridgeDriver/#libvirt_vif_driver = nova.virt.libvirt.vif.LibvirtHybirdOVSBridgeDriver/g" /etc/nova/nova.conf
sed -i "s/^linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver/#linuxnet_interface_driver = nova.network.linux_net.LinuxOVSInterfaceDriver/g" /etc/nova/nova.conf
sed -i "s/^firewall_driver = nova.virt.libvirt.firewall.IptablesFirewallDriver/#firewall_driver = nova.virt.libvirt.firewall.IptablesFirewallDriver/g" /etc/nova/nova.conf

# network setup
sed -i "s/^#network_manager=nova.network.manager.VlanManager/network_manager=nova.network.manager.FlatDHCPManager/g" /etc/nova/nova.conf
sed -i "s/^#force_dhcp_release/force_dhcp_release/g" /etc/nova/nova.conf
sed -i "s/^#dhcpbridge_flagfile/dhcpbridge_flagfile/g" /etc/nova/nova.conf
sed -i "s/^#dhcpbridge/dhcpbridge/g" /etc/nova/nova.conf
sed -i "187iauto_assign_floating_ip=True" /etc/nova/nova.conf


######################
# nova-compute.conf
#####################
sed -i "s/^libvirt_vif_driver=.*/libvirt_vif_driver=nova.virt.libvirt.vif.LibvirtBridgeDriver/g" /etc/nova/nova-compute.conf

# Create the fixed (private) network
nova-manage network create private --fixed_range_v4=10.0.0.0/25 --num_networks=1 --bridge=br100 --bridge_interface=dummy0 --network_size=128

# Create the floating (public) network
nova-manage floating create --ip_range=172.23.12.0/24

# Restart services
./stackswitch.sh restart

# Show the network
nova-manage network list


#################
# CINDER
################

echo '################################################################'
echo 'create the cinder volume group with:'
echo 'pvcreate -ff /dev/sdX'
echo 'vgcreate cinder /dev/sdX'
echo ''
echo 'Be careful this will destroy data!!!'
echo '################################################################'


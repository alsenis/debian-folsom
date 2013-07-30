# add user to sudoers


# remove CD source from /etc/apt/sources.list
#sed -i "s/^deb cdrom:/# deb cdrom:/g" /etc/apt/sources.list

cat > /etc/apt/sources.list.d/folsom.list <<EOF
deb http://openstack.dachary.org/2013-02-20 ./
deb-src http://openstack.dachary.org/2013-02-20 ./
EOF
apt-get update

cat >> /etc/network/interfaces <<EOF
auto dummy0
iface dummy0 inet static
       address 192.168.42.1
       netmask 255.255.255.0
       network 192.168.42.0
       broadcast 192.168.42.255
EOF
ifup dummy0

# Get presseed example
wget http://openstack.dachary.org/2013-01-13/folsom-example-preseed.txt

# Don't need this either
#wget http://openstack.dachary.org/2013-01-13/automagical_openstack.txt

# Modify preseed example with our data
ETH0_IP=$(ifconfig eth0 | sed -n 's/.*dr:\(.*\) Bc.*/\1/p');
DUMMY0_IP=$(ifconfig dummy0 | sed -n 's/.*dr:\(.*\) Bc.*/\1/p');

sed -i "s/ENDPOINT_IP/$ETH0_IP/g" folsom-example-preseed.txt
sed -i "s/PRIVATE_IP/$DUMMY0_IP/g" folsom-example-preseed.txt
sed -i "s/AUTH_TOKEN/ADMIN/g" folsom-example-preseed.txt

# source mystackrc
. mystackrc

echo ""
echo "***********************************************************"
echo "Run this:"
echo "cat folsom-example-preseed.txt | debconf-set-selections"
echo "./install.sh"
echo "during the install debconf will ask, reply with the default"
echo "dont set any passwords, leave them blank"
echo "let debconf register tenants automatically"
echo "***********************************************************"

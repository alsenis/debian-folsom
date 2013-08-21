# run regular install http://openstack.dachary.org/2013-01-13/



apt-get install -y dbconfig-common
apt-get install -y chkconfig
apt-get install -y mysql-server
apt-get install -y --force-yes keystone 
#apt-get install -y --force-yes python-cinderclient python-glanceclient memcached rabbitmq-server ntp cinder-api cinder-scheduler glance nova-api nova-console nova-scheduler nova-xvpvncproxy openstack-dashboard-apache nova-api nova-cert nova-compute nova-compute-kvm nova-network cinder-volume iscsitarget
apt-get install -y --force-yes kvm python-cinderclient python-glanceclient memcached rabbitmq-server ntp cinder-api cinder-scheduler glance nova-api nova-console nova-scheduler nova-xvpvncproxy openstack-dashboard-apache nova-api nova-cert nova-compute nova-compute-kvm nova-network cinder-volume cinder-scheduler tgt

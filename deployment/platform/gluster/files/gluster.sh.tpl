#!/usr/bin/env bash

vgcreate pers /dev/nvme1n1
lvcreate -T -L 9G  pers/glusterfs-pool
lvcreate -V 9G --thin -n glusterfs  pers/glusterfs-pool

mkfs.xfs /dev/mapper/pers-glusterfs
mkdir -p /opt/glusterfs
echo "" >> /etc/fstab
echo "/dev/mapper/pers-glusterfs /opt/glusterfs xfs defaults  0 0" >> /etc/fstab
mount -a

###
systemctl enable glusterfs-server
systemctl start  glusterfs-server
mkdir -p /opt/glusterfs/brick

if test "$1" = "yes";
  then
    sleep 60
    %{ for node in nodes ~}
    gluster peer probe ${node}
    %{ endfor }

    gluster volume create ${name} replica 3 %{ for node in nodes ~}${node}:/opt/glusterfs/brick %{ endfor }

    gluster volume start ${name}
    gluster volume set ${name} ctime off
    gluster snapshot config activate-on-create enable
    echo "59 22 * * * root gluster snapshot create ${name} ${name}" >> /etc/crontab
fi

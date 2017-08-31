#!/bin/bash -vx
set -u

echo 'Enter the name of your VM (EXCLUDING FDQN)'
read vm_name

#echo 'Enter the full hostname of the virt (includeing FDQN) where this VM is hosted:'
#read virt

#echo 'Enter your LDAP password'
#read pw

echo 'Enter the size in GB you wish to increase the VM by (without typeing units)'
read size

#loginto VM
#ssh $virt

#need to add clause if fails to ssh then:
# echo "failed conection" && exit 1
#

#echo | sudo su
#echo "$pw"
#echo "\n"

#Get the name of the vm from the full FQDN


#condition to check if VM is running
#if [[ "$( virsh domstate $vm_name )" != 'running' ]]; then

  #find disk and create a back-up (works)
  cd /var/virt/disks/
  cp -prv $vm_name-disk0 $vm_name-disk0-backup
  sync

  #add the memory (works)
  qemu-img resize $vm_name-disk0 +$size"G"

  # THIS IS NOT TESTED YET
echo 'd
3

n
p
3


w
' | fdisk /var/virt/disks/$vm_name-disk0


  export offset=$(fdisk -l /var/virt/disks/$vm_name-disk0 | awk '/Sector size/ {size=$4} END {print $2*size}')

  mkdir ~/tempdir
  mount /var/virt/disks/$vm_name-disk0 ~/tempdir -o loop,offset=${offset}
  xfs_growfs ~/tempdir

  umount ~/tempdir && rmdir ~/tempdir
  #rm -f $vm_name"-disk0-backup"

  virsh start $vm_name

#  else
 #   echo 'VM is still running'

#fi

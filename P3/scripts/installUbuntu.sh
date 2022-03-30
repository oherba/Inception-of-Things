MACHINENAME=$1
WORKDIR=~/goinfre
BASEFOLDER=$WORKDIR/"VirtualBox VMs"/$MACHINENAME

# Download debian.iso
if [ ! -f "$WORKDIR"/Ubuntu_64.iso ]; then
    curl https://releases.ubuntu.com/18.04/ubuntu-18.04.6-live-server-amd64.iso --output $WORKDIR/Ubuntu_64.iso
fi

#Create directory
if [ ! -d "$BASEFOLDER" ]; then
    mkdir "$BASEFOLDER"
fi
#Create VM
VBoxManage createvm --name $MACHINENAME --ostype "Ubuntu_64" --register
#Set memory and network
VBoxManage modifyvm $MACHINENAME --ioapic on
VBoxManage modifyvm $MACHINENAME --memory 4096 --vram 128 --cpus 4
VBoxManage modifyvm $MACHINENAME --nic1 nat
VBoxManage modifyvm $MACHINENAME --natpf1 "guestssh,tcp,,2222,,22"
VBoxManage modifyvm $MACHINENAME --natpf1 "http,tcp,,80,,80"
#Create Disk and connect Debian Iso
VBoxManage createhd --filename "$BASEFOLDER"/$MACHINENAME_DISK.vdi --size 120000 --format VDI
VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  "$BASEFOLDER"/$MACHINENAME_DISK.vdi
VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $WORKDIR/Ubuntu_64.iso
VBoxManage modifyvm $MACHINENAME --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
VBoxManage modifyvm $MACHINENAME --vrde on
VBoxManage modifyvm $MACHINENAME --vrdemulticon on --vrdeport 10001

#Start the VM
#VBoxHeadless --startvm $MACHINENAME --type headless

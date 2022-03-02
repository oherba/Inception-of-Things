systemctl stop firewalld
systemctl disable firewalld
curl -sfL https://get.k3s.io | sh -s - - --write-kubeconfig-mode '644' --flannel-iface eth1 --node-ip 192.168.42.110
sleep 3

sudo systemctl stop firewalld
sudo systemctl disable firewalld
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.42.110:6443 K3S_TOKEN=$(cat /home/vagrant/data/token.txt)  sh -s - - --flannel-iface 'eth1' --node-ip 192.168.42.111 --write-kubeconfig-mode '644'
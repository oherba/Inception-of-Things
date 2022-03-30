sudo apt-get update -y
sudo apt-get upgrade -y
#install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
#install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#install docker
sudo apt-get install -y docker.io

# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
sudo chmod 666 /var/run/docker.sock
sleep 10


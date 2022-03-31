USER=$1
if [ ! $USER ]; then
    echo "You Need to spicify the User Name"
else
k3d cluster create  -p "80:80@loadbalancer"  -p "8888:8888@loadbalancer"   --wait
kubectl apply -f /home/$USER/confs/namespc.yaml
kubectl apply -f /home/$USER/confs/install-argocd.yaml -n argocd
kubectl wait --for=condition=Ready pods --all -n argocd
kubectl apply -f /home/$USER/confs/ingress.yaml -n argocd
kubectl apply -f /home/$USER/confs/application.yaml
fi
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="data.password}" | base64 -d; echo
#ssh-copy-id -i ~/.ssh/mykey user@host id_rsa
#scp -i /Users/akhourba/.ssh/id_rsa -rP 2222 ./data akhourba@127.0.0.1:/home/akhourba/something

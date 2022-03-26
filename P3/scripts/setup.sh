k3d cluster create  -p "80:80@loadbalancer"  -p "8888:8888@loadbalancer"  -p "30002:30002@loadbalancer"  --wait
kubectl apply -f confs/namespc.yaml
kubectl apply -f confs/gitlab-dep.yaml
kubectl wait --for=condition=Ready pods --all -n gitlab
kubectl apply -f confs/install-argocd.yaml -n argocd
kubectl wait --for=condition=Ready pods --all -n argocd
kubectl apply -f confs/ingress.yaml -n argocd
kubectl apply -f confs/application.yaml



echo "----YES_____"
kubectl apply -f $(pwd)/confs/client-pod.yaml
kubectl apply -f $(pwd)/confs/client-ser.yaml
echo "hmmmm ----"
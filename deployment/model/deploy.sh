kubectl apply -f env-secret.yaml
kubectl apply -f env-configmap.yaml

# Deployments
kubectl apply -f backend-feed-deployment.yaml
kubectl apply -f backend-user-deployment.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f reverseproxy-deployment.yaml

# Service
kubectl apply -f backend-feed-service.yaml
kubectl apply -f backend-user-service.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f reverseproxy-service.yaml

#Expose External IP
kubectl expose deployment frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy
#Autoscaling
kubectl autoscale deployment reverseproxy --cpu-percent=70 --min=3 --max=5
kubectl autoscale deployment backend-user --cpu-percent=70 --min=3 --max=5
kubectl autoscale deployment backend-feed --cpu-percent=70 --min=3 --max=5
kubectl autoscale deployment frontend --cpu-percent=70 --min=3 --max=5
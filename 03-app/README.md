# 03-app

## deploy

apply:

```bash
kubectl apply -k base
```

view resources:

```bash
kubectl get -k base
```

## test

get your nginx ingress external ip address

```bash
kubectl get -k ./base
SERVICE_IP='...'

# or

SERVICE_IP=$(kubectl get service -n ingress-nginx ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo $SERVICE_IP

curl "http://${SERVICE_IP}/test/hello"
```

## deploy keda-http scaledobject
```bash
kubectl apply -k keda-http
```

## test single request on /test/ endpoint
```bash
curl "http://${SERVICE_IP}/test/hello/wait?ms=5000"
```

## test single request on /keda/ endpoint
```bash
curl "http://${SERVICE_IP}/keda/wait?ms=450"
```

## load test on /keda/ endpoint
```bash
hey -c 250 -n 10000 "http://${SERVICE_IP}/keda/wait?ms=350"
```

## resources
- <https://github.com/rakyll/hey#installation>
- <https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/>
- <https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/>
- <https://kubernetes.github.io/ingress-nginx/examples/rewrite/>

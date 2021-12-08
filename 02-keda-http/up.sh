[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
[[ -z "${AKS_NAME:-}" ]] && AKS_NAME='aks1'
[[ -z "${NAMESPACE:-}" ]] && NAMESPACE='keda-http'

echo "az aks get-credentials"
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_NAME \
    --overwrite-existing 

echo "helm - keda"
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm install keda kedacore/keda \
    --create-namespace \
    --namespace ${NAMESPACE} \
    --set watchNamespace=${NAMESPACE}

echo "helm - http-add-on"
helm install http-add-on kedacore/keda-add-ons-http \
    --create-namespace \
    --namespace ${NAMESPACE}

echo "helm - ingress-nginx"
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

echo "kubectl - wait"
kubectl wait --for="condition=Ready" pods --all -n $NAMESPACE --timeout=30s

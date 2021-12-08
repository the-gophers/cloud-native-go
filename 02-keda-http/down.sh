[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
[[ -z "${AKS_NAME:-}" ]] && AKS_NAME='aks1'
[[ -z "${NAMESPACE:-}" ]] && NAMESPACE='keda-http'

echo "az aks get-credentials"
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_NAME \
    --overwrite-existing 

echo "helm - ls"
helm ls -n $NAMESPACE

echo "helm - http-add-on"
helm delete -n $NAMESPACE http-add-on

echo "helm - keda"
helm delete -n $NAMESPACE keda

echo "kubectl - ns"
# kubectl delete crd httpscaledobjects.http.keda.sh
# delete: scaledobject.keda.sh/keda-add-ons-http-interceptor
# see also: https://www.ibm.com/docs/en/cloud-private/3.2.0?topic=console-namespace-is-stuck-in-terminating-state
kubectl get -n $NAMESPACE HttpScaledObject -o name | xargs -n 1 
kubectl delete ns $NAMESPACE

echo "kubectl - wait"
kubectl wait --for=delete "ns/${NAMESPACE}" --timeout=30s

[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
[[ -z "${AKS_NAME:-}" ]] && AKS_NAME='aks1'

echo "az aks get-credentials"
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_NAME \
    --overwrite-existing 

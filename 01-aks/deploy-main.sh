[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
[[ -z "${LOCATION:-}" ]] && LOCATION='eastus'
[[ -z "${AKS_NAME:-}" ]] && AKS_NAME='aks1'

az deployment sub create \
    --location $LOCATION \
    --template-file ./main.bicep \
    --parameters \
        resourceGroup=$RESOURCE_GROUP

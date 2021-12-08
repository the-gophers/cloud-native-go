[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
[[ -z "${LOCATION:-}" ]] && LOCATION='eastus'

#az group create \
#    --name $RESOURCE_GROUP \
#    --location $LOCATION

az deployment group create \
    --resource-group $RESOURCE_GROUP \
    --mode incremental \
    --template-file ./deploy-script.bicep 

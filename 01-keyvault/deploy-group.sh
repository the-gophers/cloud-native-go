[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'

az deployment group create \
    --resource-group $RESOURCE_GROUP \
    --mode incremental \
    --template-file ./keyvault.bicep 

# https://docs.microsoft.com/en-us/azure/container-registry/container-registry-quickstart-task-cli

[[ -z "${RESOURCE_GROUP:-}" ]] && RESOURCE_GROUP='211200-cloud-native'
ACR_NAME=$(az acr list --resource-group $RESOURCE_GROUP --query '[0].name' --out tsv)

[[ -z "${OWNER:-}" ]] && OWNER='asw101'
[[ -z "${IMAGE:-}" ]] && IMAGE='test'
[[ -z "${TAG:-}" ]] && TAG='latest'

az acr build -t ${OWNER}/${IMAGE}:${TAG} -r $ACR_NAME .

echo "${ACR_NAME}.azurecr.io/${OWNER}/${IMAGE}:${TAG}"

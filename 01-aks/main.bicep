targetScope = 'subscription'

param resourceGroup string = '210900-aks'
param location string = 'eastus'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroup
  location: location
}

module aks './aks.bicep' = {
  name: '${resourceGroup}-aks'
  scope: rg
  params: {
  }
}

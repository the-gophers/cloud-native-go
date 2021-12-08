param location string = ''
param utcValue string = utcNow()
param scriptUri string = 'https://gist.githubusercontent.com/asw101/7a6b58998c5bb4f538b169e2d0b332a0/raw/468e7dd6752d042392df57ffa26565aee1a9b8ce/211200-up.sh'

var location_var = location != '' ? location : resourceGroup().location

resource managedIdentityDeploy 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: '${resourceGroup().name}-identity-deploy'
  location: location_var
}

var roleDefinitionId = {
  Owner: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  Contributor: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
  Reader: 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
}

// https://github.com/Azure/bicep/discussions/3181
var roleAssignmentDeploymentContributorDefinition = 'Contributor'
resource roleAssignmentDeploymentContributor 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(managedIdentityDeploy.id, roleAssignmentDeploymentContributorDefinition)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId[roleAssignmentDeploymentContributorDefinition])
    principalId: managedIdentityDeploy.properties.principalId
  }
  dependsOn: [
    managedIdentityDeploy
  ]
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deploy-script'
  location: resourceGroup().location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentityDeploy.id}': {}
    }
  }
  properties: {
    environmentVariables: [
      {
        name: 'RESOURCE_GROUP'
        value: '211200-cloud-native'
      }
      {
        name: 'AKS_NAME'
        value: 'aks1'
      }
      {
        name: 'NAMESPACE'
        value: 'keda-http'
      }
    ]
    forceUpdateTag: utcValue
    azCliVersion: '2.28.0'
    timeout: 'PT30M'
    //arguments: '\'211200-cloud-native\''
    //scriptContent: 'echo "arg1 is: $1"; value=$1; echo \'{}\' | jq --arg value "$value" \'.Result = $value\' | tee $AZ_SCRIPTS_OUTPUT_PATH'
    primaryScriptUri: scriptUri
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

//output result object = deploymentScript.properties.outputs

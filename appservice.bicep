//res-we
res-resource azbicepaps 'Microsoft.Web/sites@2018-11-01' = {
  name: 'azbicep-dev-eus-webapp1'
  location: resourceGroup().location
  // tags: {
  //   'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  // }
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'azbicep-dev-eus-asp1')
  }
}



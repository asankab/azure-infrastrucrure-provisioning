
param location string = resourceGroup().location

//res-p and tab
resource azbicepasp1 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: location
  sku: {
    name: 'S1' //procing tier
    capacity: 1 // no of instances
  }
}

//res-we
resource azbicepwap1 'Microsoft.Web/sites@2018-11-01' = {
  name: 'azbicep-dev-eus-webapp1'
  dependsOn: [azbicepasp1]
  location: location
  // tags: {
  //   'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  // }
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'azbicep-dev-eus-asp1')
  }
}

//res-p and tab
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-eus-asp1-linux'
  kind: 'linux'
  properties: {
    reserved: true
  }
  location: resourceGroup().location
  sku: {
    name: 'S1' //procing tier
    capacity: 1 // no of instances
  }
}

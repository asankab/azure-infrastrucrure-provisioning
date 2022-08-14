targetScope = 'subscription'

var rgName = 'deployFromBicepRG'
resource myNewGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: 'southeastasia'
}

module storageModule 'storage.bicep' = {
  name: 'storageModule'
  scope: resourceGroup(myNewGroup.name)
  params: {
    storageName: '20125252storage'
  }
}

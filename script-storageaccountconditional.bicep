@description('Specifies the location for resources.')
param location string = 'eastus'

var prefix = 'dev'
var storageAccountName = '${prefix}bicepstorageaccount'

// resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = if ( prefix == 'prod') {
//   name: storageAccountName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Cool' //Hot
//   }
// }

resource storageAccount2 'Microsoft.Storage/storageAccounts@2019-06-01' = if ( prefix == 'dev') {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool' //Hot
  }
}

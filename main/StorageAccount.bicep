@minLength(3)
// @maxLength(11)
param storageName string

resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: 'southeastasia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output storageEndpoint object = storageAccount1.properties.primaryEndpoints

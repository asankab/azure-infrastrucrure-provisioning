@minLength(3)
@maxLength(11)
params storageName string = 'bicepdemostorageaccount'

resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: 'southeastasia'
  sku: {
    name: 'Standard-LRS'
  }
  kind 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

output storageEndpoint object = storageAccount1.properties.primaryEndpoints

@description('Specifies the regions for resources.')
var regions = [
  'eastus'
  'southeastasia'
  // 'northeurope'
  // 'CentralUS'
]

var prefix = 'prod'
var storageAccountName = '${prefix}bicepstorageaccount'

resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = [ for (region,i) in  regions: { 
    name: '${storageAccountName}${i}'
    location: region
    sku: {
      name: 'Standard_LRS'
    }
    kind: 'StorageV2'
    properties: {
      accessTier: 'Cool'
    }
  }]

var prefix = 'prod'
var storageAccountName = '${prefix}20220814storageacc'

var regions = [
  'eastus'
  'southeastasia'
  'northeurope'
  'CentralUS'
]

// @allowed([
//   'westeurope'
//   'northeurope'
// ])

// sku: {
//   name: 'Standard-LRS'
//   // name: 'Premium_LRS'
//   // tier: 'Standard'
// },

// kind: 'StorageV2' //kind 'BlobStorage'

resource storageAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = [ for {region, i} in regions: {
  name: ${storageAccountName}${i}
  location: region
  sku: {
    name: 'Standard-LRS'
  }
  kind: 'StorageV2'
  properties: {
    // accessTier: 'Hot'
    accessTier: 'Cool'
  }
}

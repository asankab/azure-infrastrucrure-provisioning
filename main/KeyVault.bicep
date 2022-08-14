
param location string = resourceGroup().location
param login string

@secure()
param password string

param tenantId string = 'de250e7c-78c1-4992-a899-0163bdcd272d'
param objectId string = 'e788904c-d590-4b21-9b80-268d10f494e6'

// res-kv
resource kv 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'azbicepkv01'
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantId
    accessPolicies: [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          keys: [
            'list'
            'get'
          ]
          secrets: [
            'list'
            'get'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource secret1 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: kv
  name: 'adminpass'
  properties: {
    value: 'adminpassword#'
  }
}

resource secret2 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: kv
  name: 'api-key'
  properties: {
    value: 'api-key#'
  }
}



param location string = resourceGroup().location
param tanantId string = 'mytenantid'

@secure()
param pass string //will propt during runtime

resource kv 'Microsoft.KeyVault/sites@2021-11-01-preview' = {
  name: 'nkeycvv3445-kv01'
  tags: {

  }
  location: location
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: [
        {
          value: '1.2.3.4/32'        
        }
      ]
    }
  }
  sku: {
    family: 'A'
    name: 'Standard'
  }
  tenantId: tanantId
  accessPolicies: [
    {
      objectId: 'MyAzureActiveDirctoryUserObjectIdSecrets'
      tenantId: tanantId
      permissions: {
        secrets: [
          'get'
          'set'
          'list'
        ]
      }
    }
    {
      objectId: 'MyAzureActiveDirctoryUserObjectIdCertificate'
      tenantId: tanantId
      permissions: {
        certificates: [
          'all'
        ]
      }
    }
    {
      objectId: 'MyAzureActiveDirctoryUserObjectIdKeys'
      tenantId: tanantId
      permissions: {
        keys: [
          'create'
          'delete'
          'get'
          'recover'
        ]
      }
    }
  ]
}

//New-AzResourceGroupDeployment -ResourceGroupName dev -TemplateFile .\keyvault.bicep -Mode Incremental -verbose

resource secret1 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: 'kv'
  name: 'adminpass'
  properties: {
    value: pass
  }
}

resource secret2 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: 'kv'
  name: 'secret2'
  properties: {
    value: 'heyehhe'
  }
}

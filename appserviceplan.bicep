
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

// app-i
resource azbicepappinsights1 'Microsoft.Insights/components@2020-02-02-preview' = {
  dependsOn: [azbicepwap1]
  name: 'azbicep-dev-eus-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

//integrate appisnights with appservice
resource azbicepwebappappsettings 'Microsoft.Web/sites/config@2021-01-15' = {
  name: 'web'
  parent: azbicepwap1
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATION_KEY'
        value: '76730c7e-9be2-4f1f-b35e-e3d05bba093b'
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
}



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

param login string

@secure()
param password string

// integrate KV secrets with appservice

//NEXT

// provision sql server db

// whitelistt ips

// running on multiple environments

// pipelines


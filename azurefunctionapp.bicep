param location string = resourceGroup().location

@description('Resource name prefix')
param resourceNamePrefix string
var envResourceNamePrefix = toLower(resourceNamePrefix)

@description('Deployment name')
param deploymentNameId string

@description('Name of the staging slot of the functionapp')
param functionappStagingSlot string = 'staging'

resource azStorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: '${envResourceNamePrefix}storage'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

var azStorageAccountPrimaryAccessKey = listKeys(azStorageAccount.id, azStorageAccount.apiVersion).keys[0].value

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: '${envResourceNamePrefix}ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

var azAppInsightsInstrumetationKey = appInsightsComponents.properties.InstrumentationKey

resource azHostingPlan 'Microsoft.Web/servcerfarms@2021-03-01' = {
  name: '${envResourceNamePrefix}asp'
  location: location
  kind: 'linux'
  sku: {
    name: 'S1'
  }
  properties: {
    reserved: true
  }
}

resource azFunctionApp 'Microsoft.Web/sites@2020-12-01' = {
  name:  '${envResourceNamePrefix}app'
  location: location
  kind: 'functionapp'
  
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    httpsOnly: true
    serverFarmId: azHostingPlan.id
    clientAffinityEnabled: true
    reserved: true
    siteConfig: {
      alwaysOn: true
      linuxFxVersion: 'NODE|14'
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName1;AccountKey=${listKeys('storageAccountID1', '2019-06-01').key1}'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName2;AccountKey=${listKeys('storageAccountID2', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=storageAccountName3;AccountKey=${listKeys('storageAccountID3', '2019-06-01').key1}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower('name')
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~2'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference('insightsComponents.id', '2015-05-01').InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
}

resource azFunctionSlotsStaging 'Microsoft.Web/sites/slots@2022-03-01' = {
  name: '${azFunctionApp}/${functionappStagingSlot}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    httpsOnly: true
  }
}

// resource azFunctionSlotsStaging 'Microsoft.Web/sites/config@2022-03-01' = {
//   name: 'slotConfigNames'
//   parent: azFunctionApp
//   properties: {
//     appSettingsNames: {
//       'APP_CONFIGURATION_LABEL'
//     }
//   }
// }

module appService_appSettings 'appsettings.bicep' = {
  name: '${deploymentNameId}-grant-appservice-app-config'
  params: {
    applicationInsightsInstrumentationKey: azAppInsightsInstrumetationKey
    storageAccountName: azStorageAccount.name
    storageAccountAccessKey: azStorageAccountPrimaryAccessKey
    functionAppName: azFunctionApp.name
    functionappStagingSlotName: azFunctionAppStagingSlot.name
  }
}

output appInsightsInstrumetationKey string = azAppInsightsInstrumetationKey
output functionAppName string = azFunctionApp.name
output functionappStagingSlotName string = functionappStagingSlot


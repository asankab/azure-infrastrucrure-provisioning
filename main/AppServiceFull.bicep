
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

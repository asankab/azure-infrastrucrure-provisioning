
param location string = resourceGroup().location
param parentWebAppName string = ''

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

//integrate appinsights with appservice
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

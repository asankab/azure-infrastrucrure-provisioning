param appInsightsInstrumetationKey string
param storageAccountName string
param storageAccountAccessKey string
param functionAppName string
param functionappStagingSlot string

param appConfiguration_appConfigLabel_value_production string = 'prduction'
param appConfiguration_appConfigLabel_value_staging string = 'staging'

var BASE_SLOT_APPSETTINGS = {
  APPINSIGHTS_INSTRUMENTATION_KEY:appInsightsInstrumetationKey
  FUNCTIONS_WORKER_RUNTIME: 'node'
}

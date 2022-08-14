param login string

@secure()
param password string

param pAppSevicePlan string  = 'azbicep-dev-eus-asp1'
param pAppSevice string  = 'azbicep-dev-eus-wap1'
param pAppInsights string  = 'azbicep-dev-eus-wap1ai'
param pSQLServer string  = 'azbicep-dev-eus-sqlserver'

module AppServicePlan 'AppServicePlan.bicep' = {
  name: 'AppServicePlan'
  params: {
    pAppSevicePlan: pAppSevicePlan
    pAppSevice: pAppSevice
    pAppInsights: pAppInsights
  }
}

module SQLDatabase 'SQLDatabase.bicep' = {
  name: 'SQLDatabase'
  params: {
    pSQLServer: pSQLServer
  }
}

//bicep build ./main.bicep

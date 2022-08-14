param location string = resourceGroup().location
// param sqlServerName string = ''
// param databaseName string = ''
// param allowIpStart string = ''
// param allowIpEnd string = ''

//sql
resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' ={
  name: 'azbicep-dev-eus-sqlserver'
  location: location
  properties: {
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: 'administratorLoginPassword'
  }
}

resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2020-11-01-preview' = {
  parent: sqlServer
  name: 'My Ip Address'
  properties: {
    startIpAddress: '1.1.1.1'
    endIpAddress: '1.1.1.1'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: 'database1'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    edition: 'Basic'
    maxSizeBytes: '2147483648'
    requestedServiceObjectiveName: 'Basic'
  }
}

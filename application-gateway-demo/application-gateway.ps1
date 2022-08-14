$loc = 'southeastasia'
$rgp = 'ApplicationGatewayDemo'
$pln = 'AppGwDemoPlan'

#RG
az group create --name $rgp --location $loc

#WebApp1
$appname = 'demo-images-01'
az appservice plan create --name $pln --resource-group $rgp --location $loc --sku S1
az webapp create --name $appname --plan $pln --resource-group $rgp

#WebApp2
$appname = 'demo-videos-01'
# az appservice plan create --name $pln --resource-group $rgp --location $loc --sku S1
az webapp create --name $appname --plan $pln --resource-group $rgp
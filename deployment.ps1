#az login 
#RUN in powershell 

#Single Storage Account in one Region
$rg = "WWSOLabsBicepRG"

az group create --name $rg
az deployment group create --resource-group $rg --template-file .\script-singlestorageaccount.bicep --mode Complete
#az group deployment create --resource-group $rg --template-file \script.bicep --mode Incremental -verbose
az group delete --resource-group $rg --yes


#Storage Accounts in multiple Regions

az group create --name $rg
az deployment group create --resource-group $rg --template-file .\script-storageaccountsinmultiregion.bicep --mode Complete
#az group deployment create --resource-group $rg --template-file \script.bicep --mode Incremental -verbose
az group delete --resource-group $rg --yes

#Storage Accounts in multiple Regions

az group create --name $rg
az deployment group create --resource-group $rg --template-file .\script-storageaccountconditional.bicep --mode Complete
#az group deployment create --resource-group $rg --template-file \script.bicep --mode Incremental -verbose
az group delete --resource-group $rg --yes

#Storage Accounts from Module

$location = "eastus"

az group create --name $rg
az deployment sub create --location $location --template-file .\azuredeploy.bicep
#az group deployment create --resource-group $rg --template-file \script.bicep --mode Incremental -verbose
az group delete --resource-group $rg --yes
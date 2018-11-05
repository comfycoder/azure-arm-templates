# sign in
Write-Output "Logging in...";
# Connect-AzureRmAccount

# Select Subscription
$subscriptionName = 'Visual Studio Enterprise with MSDN'
Select-AzureRmSubscription -SubscriptionName $subscriptionName

# Configure Variables
$deploymentMode = 'Incremental'
$resourceGroupName = 'RG-'
$templateBasePath = "C:\src\AKS\"
$templateFilePath = $templateBasePath + "azuredeployAKS.json"
$parametersFilePath = $templateBasePath + "azuredeployAKS.parameters.json"

# Test the deployment template
Test-AzureRmResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFilePath `
  -TemplateParameterFile $parametersFilePath;

# Start the deployment
Write-Output "Starting deployment...";
$Time = [System.Diagnostics.Stopwatch]::StartNew()

New-AzureRmResourceGroupDeployment `
  -Mode $deploymentMode `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFilePath `
  -TemplateParameterFile $parametersFilePath;

$CurrentTime = $Time.Elapsed

Write-Output $([string]::Format("`rTime: {0:d2}:{1:d2}:{2:d2}", $CurrentTime.hours, $CurrentTime.minutes, $CurrentTime.seconds)) -nonewline

# Get-AzureRMLog -CorrelationId "d1e5f4f4-f565-4188-b19b-c66acc7eb209"

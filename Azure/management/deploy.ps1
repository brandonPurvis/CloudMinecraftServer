$appId = $args[0]
$tenantId = $args[1]
$passwd = ConvertTo-SecureString $args[2] -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential($appId, $passwd)
Connect-AzAccount -ServicePrincipal -Credential $pscredential -TenantId $tenantId


$ResourceGroupName = "developServer"
$TemplateLocation = "C:\Users\bcpma\Projects\CloudMinecraft\Azure\arm\deploy-minecraftserver.json"

try
{
    Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction Stop
}
catch
{
    echo "Resource Group $ResourceGroupName Does Not Exist."
    echo "Creating Group $ResourceGroupName."
    $Response = New-AzResourceGroup -Name $ResourceGroupName -ErrorAction Stop
}

$DeployResponse = New-AzResourceGroupDeployment -TemplateFile $TemplateLocation  -ResourceGroupName $ResourceGroupName

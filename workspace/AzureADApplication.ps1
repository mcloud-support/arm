# 以CSP身分登入租用戶 Azure Portal，進入Cloud Shell ( PowerShell)
# 請取代一處實際的值 <replace-your-subscription-Id-in-here>
# 複製所有指令到 Cloud Shell 執行
Connect-AzureAD
# 註冊 AAD 應用程式
$app = New-AzureADApplication -DisplayName "MCB-Monitor-Portal" -HomePage "https://mon.mcloud.cht.com.tw" -ReplyUrls "https://mon.mcloud.cht.com.tw"
$app

# 授予 Subscription 權限，請取代此處 <replace-your-subscription-Id-in-here>
New-AzADServicePrincipal -Role Contributor -Scope "/subscriptions/<replace-your-subscription-Id-in-here>" -ApplicationId $app.AppId

# 授予讀取 Microsoft Graph 權限
$apiPermission01 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"

$permission0101 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "e1fe6dd8-ba31-4d61-89e7-88639da4683d","Scope"

$apiPermission01.ResourceAccess = $permission0101
$apiPermission01.ResourceAppId = "00000003-0000-0000-c000-000000000000"

 # 授予讀取 Log Analytics API 權限
$apiPermission02 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"

$permission0201 = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList "e8dac03d-d467-4a7e-9293-9cca7df08b31","Scope"

$apiPermission02.ResourceAccess = $permission0201
$apiPermission02.ResourceAppId = "ca7f3f0b-7d91-482c-8e09-c5d840d0eac5"
 
Set-AzureADApplication -ObjectId $app.ObjectId  -RequiredResourceAccess @($apiPermission01,$apiPermission02)

#添加密鑰，密鑰會输出
New-AzureADApplicationPasswordCredential -ObjectId $app.ObjectId -EndDate "12/31/2099" -CustomKeyIdentifier "secret"

#查詢 Tenant Id
Get-AzureADTenantDetail -All $false

Disconnect-AzureAD
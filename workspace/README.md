# 設定用戶端自動收集監控資源、服務、與應用程式紀錄

> 準備工作：先以 MCB 管理身分登入 Azure Portal ，查詢 Azure Service Bus 管理功能，複製 MCB Service Bus Send Only Connection String (MCB連線密語字串) 備用，然後進行下列步驟。
---
## 登入用戶端 Azure Portal
1. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-100-CreateWorkspace.json) 自動部署下列資源：
   * 新建 Log Analytics Workspace
   * 啟動 Workspace 診斷監測
   * 啟用 VMInsight Solution </P>
2. 登入 Azure Portal，進入管理 console，Log Analytics workspaces > your workspace name > General > Properites ，即可見詳細資訊，複製 Resource Id 備用，Workspace FQDN Resource Id，如：/subscriptions/\<subscription id\>/resourcegroups/\<resourcegroup name\>/providers/microsoft.operationalinsights/workspaces/\<workspace name\>
3. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-101-EnableDiagnosticSetting.json) 自動部署下列資源：
   * 啟用 Monitor Diagnostic Setting
4. 執行下列建置，須先取得合法的 MCB Azure Service Bus 的 Shared access policies 連線密語字串，請洽 MCB 管理人員索取
5. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Flogicapp%2FM-200-ForwardingAlertsSet.json) 自動部署下列資源：
   * 必需填入事先備妥的 MCB 連線密語字串
   * 建立 MCB-ServiceBusConnection 連接 MCB 訊息服務中心。
   * 建立 MCB-AzureAlertToServiceBus Logic App 並啟動診斷監控，轉發 Azure Alert 到 MCB 訊息服務中心。
   * 產生 ForwardToMCB-ActionGroup 讓 Azure Alert 設定驅動轉發。
   * 建立 MCB-RoutedIntoServiceBus Logic App 並啟動診斷監控，回傳 MCB-RoutedIntoServiceBus Web hook Credentials String 與 ActionGroup 資訊。
6. 後續自訂 Azure Alert 設定時，可指名加入此 ForwardToMCB-ActionGroup為通知對象，即可整合傳送訊息到 MCB Portal 事件中心
7. 啟用各式資源、服務、或應用程式監控偵測功能
   1. 以 VM 為例，VM建立完成，使用 ExistingVmOnboardingTemplate.json 納管指定的 VM 啟用 Agent 監控，可執行Alert腳本
   2. 以 SQL Service為例，使用 EnableSQLDiagnosticSetting-template.json 納管指定的資料庫，啟用 Agent 監控

## 登入 MCB Portal，設定 Monitor 服務
1. MCB Monitor platform 上新增 Alert Notificaiton Channels，設定Web Hook 填入回傳 MCB-RoutedIntoServiceBus Web hook Credentials String，即可整合傳送訊息到 MCB Portal



# 設定用戶端自動收集監控資源、服務、與應用程式紀錄

> 準備工作：先以 MCB 管理身分登入 Azure Portal ，查詢 Azure Service Bus 管理功能，複製 MCB Service Bus Send Only Connection String (MCB連線密語字串) 備用，然後進行下列步驟。
---
## 登入用戶端 Azure Portal
1. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-100-CreateWorkspace.json) 自動部署下列資源：
   * 設定 Log Analytics Workspace，<font color=yellow size=3>此值為全域唯一</font>
   * 新建 Log Analytics Workspace
   * 啟動 Workspace 診斷監測
   * 啟用 VMInsight Solution 
   * <font color=red size=3><b>重要回傳資訊，複製暫存，用於後續設定</b></font>
     * <font color=yellow size=3>workspaceResourceId</font>: 下個步驟用來啟用 Monitor Diagnostic Setting
2. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-101-EnableDiagnosticSetting.json) 自動部署下列資源：
   * 必需填入上述提及的 workspaceResourceId
   * 啟用 Monitor Diagnostic Setting
3. 執行下列建置前，須先使用 MCB Azure Central Account 登入 Azure Portal，<font color=yellow size=3>取得 Azure Service Bus Shared Send Only policies 連線密語字串</font>，請洽 MCB Azure 管理人員索取，可參見[官網介紹](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-portal)
4. [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Flogicapp%2FM-200-ForwardingAlertsSet.json) 自動部署下列資源：
   * 必需填入上述提及的 Azure Service Bus Shared Send Only policies 連線密語字串
   * 建立 MCB-ServiceBusConnection 連接 MCB 訊息服務中心。
   * 建立 MCB-AzureAlertToServiceBus Logic App 並啟動診斷監控，轉發 Azure Alert 到 MCB 訊息服務中心。
   * 產生 ForwardToMCB-ActionGroup 讓 Azure Alert 設定驅動轉發。
   * 建立 MCB-RoutedIntoServiceBus Logic App 並啟動診斷監控
   * <font color=red size=3><b>重要回傳資訊，複製暫存，用於後續設定</b></font>
     * <font color=yellow size=3>actionGroupId</font>: 整合自訂 Azure Alert 設定時，可指名加入此 ForwardToMCB-ActionGroup 為通知對象，即可整合傳送訊息到 MCB Portal 事件中心
     * <font color=yellow size=3>logicAppUrl</font>: 整合 MCB Portal 監控服務通知功能時，所使用的 Azure Logic App 「MCB-RoutedIntoServiceBus」Web hook URL

## [僅供MSP維運人員] 登入 MCB Portal，設定 Monitor 服務 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/SETUP.md) 
1. 上一節 <font color=yellow size=3>logicAppUrl</font>: 整合 MCB Portal 監控服務通知功能時，所使用的 Azure Logic App 「MCB-RoutedIntoServiceBus」Web hook URL 請保存備用

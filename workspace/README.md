# 設定用戶端自動收集監控資源、服務、與應用程式紀錄

> 準備工作：先以 MCB 管理身分登入 Azure Portal ，查詢 Azure Service Bus 管理功能，複製 MCB Service Bus Send Only Connection String (MCB連線密語字串) 備用，然後進行下列步驟。
---
## 登入用戶端 Azure Portal
1. 點擊此處執行 ARM [ >> M-100-CreateWorkspace << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-100-CreateWorkspace.json) 自動部署下列資源：
   * 新建 Log Analytics Workspace 並啟動 Workspace 診斷監測
   * 啟用 VMInsight Solution
2. 點擊此處執行 ARM [ >> M-101-EnableDiagnosticSetting << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-101-EnableDiagnosticSetting.json) 自動部署下列資源：
   * 啟用 Monitor Diagnostic Setting
3. 點擊此處執行 ARM [ >> M-200-ForwardingAlertsSet << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Flogicapp%2FM-200-ForwardingAlertsSet.json) (必需填入事先備妥的 MCB 連線密語字串)，自動部署下列資源：
   * 建立 MCB-ServiceBusConnection 連接 MCB 訊息服務中心。
   * 建立 MCB-AzureAlertToServiceBus Logic App 並啟動診斷監控，轉發 Azure Alert 到 MCB 訊息服務中心。
   * 產生 ForwardToMCB-ActionGroup 讓 Azure Alert 設定驅動轉發。
   * 建立 MCB-RoutedIntoServiceBus Logic App 並啟動診斷監控，回傳 MCB-RoutedIntoServiceBus Web hook Credentials String 與 ActionGroup 資訊。
4. 後續自訂 Azure Alert 設定時，可指名加入此 ForwardToMCB-ActionGroup為通知對象，即可整合傳送訊息到 MCB Portal 事件中心
5. 啟用各式資源、服務、或應用程式監控偵測功能
   1. 以 VM 為例，VM建立完成，使用 ExistingVmOnboardingTemplate.json 納管指定的 VM 啟用 Agent 監控，可執行Alert腳本
   2. 以 SQL Service為例，使用 EnableSQLDiagnosticSetting-template.json 納管指定的資料庫，啟用 Agent 監控

## 登入 MCB Portal，設定 Monitor 服務
1. MCB Monitor platform 上新增 Alert Notificaiton Channels，設定Web Hook 填入回傳 MCB-RoutedIntoServiceBus Web hook Credentials String，即可整合傳送訊息到 MCB Portal
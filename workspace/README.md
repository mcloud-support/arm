# 設定用戶端自動收集監控資源、服務、與應用程式紀錄

> 準備工作：先以 MCB 管理身分登入 Azure Portal ，查詢 Azure Service Bus 管理功能，複製 MCB Central Service Bus Send Only Connection String (MCB連線密語字串) 備用，然後進行下列步驟。</p>
> <font color=yellow size=3>重要觀念，監控收集的服務或是資源，必須與 Log Analytics Workspace 在相同的 Location，例如：useast 與 japaneast 都有服務，在此處就需在個別 Location 建置 Log Analytics Workspace，各自在該 Location 下啟用診斷監測，收集到各自的 Log Analytics Workspace </font>
---
## 以CSP身分登入Azure Portal，切換至租用戶端進行監控服務配置
> 執行下列建置前，請洽 MCB Portal 管理人員索取<font color=yellow size=3> MCB Central Service Bus Send Only 連線密語字串</font>，可參見[官網介紹](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-quickstart-portal)
* 執行下列整合式部署，將自動新建收集診斷監測的工作區 Log Analytics Workspace 的所有相關資源與服務，並配置相關功能 
* [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-102-CreateMonitorWorkspaceSet.json)
* 自動堆疊部署下列資源：
   1. 新建 CmpSystemGroup 資源群組
   2. 新建收集診斷監測的工作區 Log Analytics Workspace 並配置相關功能
      * 設定 Log Analytics Workspace，<font color=yellow size=3>此值為全域唯一</font>
      * 新建 Log Analytics Workspace
      * 啟動 Workspace 診斷監測
      * 啟用 VMInsight Solution 
   3. 啟用訂閱層工作區診斷監測 Monitor Diagnostic Setting
   4. 建立與 MCB 訊息服務中心的連線，建立兩個應用程式分別轉發 Azure Alert 與 MCB Monitor Portal Alert 告警訊息到 MCB Portal 事件中心，並啟用診斷監控
      * 需填入上述提及的 MCB Central Service Bus Send Only 連線密語字串
      * 建立 MCB-ServiceBusConnection 連接 MCB 訊息服務中心。
      * 建立 MCB-AzureAlertToServiceBus Logic App 並啟動診斷監控，轉發 Azure Alert 到 MCB 訊息服務中心。
      * 產生 ForwardToMCB-ActionGroup 讓 Azure Alert 設定驅動轉發。
      * 建立 MCB-RoutedIntoServiceBus Logic App 並啟動診斷監控
      * <font color=red size=3><b>重要回傳資訊，複製暫存，用於後續設定</b></font>
        * <font color=yellow size=3>actionGroupIdFromLinked</font>: 整合自訂 Azure Alert 設定時，可指名加入此 ForwardToMCB-ActionGroup 為通知對象，即可整合傳送訊息到 MCB Portal 事件中心
        * <font color=yellow size=3>logicAppUrlFromLinked</font>: 整合 MCB Portal 監控服務通知功能時，所使用的 Azure Logic App 「MCB-RoutedIntoServiceBus」Web hook URL

## [僅供MSP維運人員] 登入 MCB Portal，設定 Monitor 服務 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/SETUP.md) 
1. 上一節 <font color=yellow size=3>logicAppUrlFromLinked</font> : 整合 MCB Portal 監控服務通知功能時，所使用的 Azure Logic App 「MCB-RoutedIntoServiceBus」Web hook URL 請保存備用

# 設定用戶端納管啟用 VM 監控與 VM 監控告警
> 準備工作：需先備妥 ForwardToMCB-ActionGroup，可以參考前述說明 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/README.md)</p>
> 後續應用：自訂 Azure Alert 設定時，可指名加入 ForwardToMCB-ActionGroup 為通知對象，即可整合傳送訊息到 MCB Portal 事件中心</p>
> 此處自動化建立告警的腳本中，觸發與監測屬性預設值為一般用途，目的是快速自動部署告警</p>
> <font color=red><h3>強烈建議</h3></font> 必須依據實際案場需要來調整各項監測屬性值，使用 Azure Portal Alert Rules 管理功能即可直接調整。
---
## 納管啟用 VM 監控偵測功能
> 執行先決條件是 VM 已經存在。
* [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Falert%2Fvm%2FM-VM-00-ExistingVmOnBoarding.json)
* 自動部署下列資源：
* 輸入指定的 VM name，自動部署 Azure OmsAgent 並啟動 Workspace 診斷監測

## 建立 VM 監控告警
### 建立監控 Linux VM 根磁碟或掛載磁碟的剩餘空間告警為例：
  * [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Falert%2Fvm%2FM-VM-01-FreeDiskSpace.json)
  * 自動部署下列資源：
  * 建立嚴重等級的「Insufficient Disk Space」 alert rule
  * 配置告警觸發時傳送訊息到指定的 ActionGroup

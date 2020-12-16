# 啟用監控偵測功能與 Alert 告警
> 以 VM 為例，VM建立完成，使用 ExistingVmOnboardingTemplate.json 納管指定的 VM 啟用 Agent 監控，可執行Alert腳本

## 泛用型告警規則
* [![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Falert%2FM-general-alert.json)
* 需先備妥，至 MCB Monitor Portal 複製要建立告警的規則查詢字串
* 自動部署下列資源：
    * 建立 Azure Alert Rule
    * 配置告警觸發時傳送訊息到指定的 ActionGroup
## VM [由此處進入](https://github.com/mcloud-support/arm/tree/main/alert/vm/README.md)
---
## Apache 應用程式 [由此處進入](https://github.com/mcloud-support/arm/tree/main/alert/apache/README.md)
---
## SQL 資料庫 [由此處進入](https://github.com/mcloud-support/arm/tree/main/alert/sqlserver/README.md)
---
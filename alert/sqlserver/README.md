# 設定用戶端 Alert 自動監控告警
> 準備工作：需先備妥 ForwardToMCB-ActionGroup，可以參考前述說明 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/README.md)</p>
> 後續應用：自訂 Azure Alert 設定時，可指名加入 ForwardToMCB-ActionGroup 為通知對象，即可整合傳送訊息到 MCB Portal 事件中心</p>
> 此處自動化建立告警的腳本中，觸發與監測屬性預設值為一般用途，目的是快速自動部署告警</p>
> <font color=red><h3>強烈建議</h3></font> 必須依據實際案場需要來調整各項監測屬性值，使用 Azure Portal Alert Rules 管理功能即可直接調整。
---
## 啟用 SQL 監控偵測功能
以 SQL Service為例，執行 EnableSQLDiagnosticSetting-template.json 納管指定的 SQL 資料庫，啟用 Agent 監控

## 建立 SQL資料庫監控告警
1. [TBD]

[![Deploy to Azure](https://docs.microsoft.com/en-us/azure/templates/media/deploy-to-azure.svg)]()
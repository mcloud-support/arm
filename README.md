# 快速進入
## 設定用戶端自動收集監控資源、服務、與應用程式紀錄 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/README.md)
## 啟用監控偵測功能與 Alert 告警 [由此處進入](https://github.com/mcloud-support/arm/tree/main/alert/README.md)

---
## Azure 監控服務基本認識
> 關於此處會使用到 Azure Monitor 服務的特性與專有名詞，這些基礎認知不是本處要說明的內容，您可以參考官方文件 [Azure Monitor Overview](https://docs.microsoft.com/zh-tw/azure/azure-monitor/overview) 來對照本文件的名詞。如圖所示

<div align=center><img src="https://docs.microsoft.com/zh-tw/azure/azure-monitor/media/overview/overview.png" align=center></div> 

Azure Monitor基於收集的Metrics與Logs，產生右側各式各樣監控的相關服務。基本上，Azure Monitor會利用OmsAgent的自動安裝與調整配置，收集monitoring data到指定的Log Analytics Workspace儲存，亦可經由調整Agent的配置，指定應用程式Log傳送到Log Analytics Workspace

<div align=center><img src="https://docs.microsoft.com/zh-tw/azure/azure-monitor/media/overview/metrics.png" align=center></div></p>
<div align=center><img src="https://docs.microsoft.com/zh-tw/azure/azure-monitor/media/overview/logs.png" align=center></div>

## Log Analytics workspace
> Azure Monitor儲存log data在Log Analytics workspace，如Figure 4所示，以tables的物件建儲存各式監測評量值與紀錄，建置規劃時可考量其費用級距，地理位置特性，授權範圍等策略，詳細說明，可參考此處[官方文件](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/azure-monitor/platform/design-logs-deployment.md)。</p>
> 針對使用 Azure 監視器 Log Analytics，用戶須支付資料擷取和資料保留的費用，關於費用可參考[官方資訊](https://azure.microsoft.com/zh-tw/pricing/details/monitor/)

<div align=center><img src="https://github.com/MicrosoftDocs/azure-docs/raw/master/articles/azure-monitor/platform/media/design-logs-deployment/logs-data-model-01.png"></div>
# 設定用戶端 Alert 自動監控告警
> 準備工作：需先備妥 ForwardToMCB-ActionGroup，可以參考前述說明 [由此處進入](https://github.com/mcloud-support/arm/tree/main/workspace/README.md)</p>
> 後續應用：自訂 Azure Alert 設定時，可指名加入 ForwardToMCB-ActionGroup 為通知對象，即可整合傳送訊息到 MCB Portal 事件中心</p>
> 此處自動化建立告警的腳本中，觸發與監測屬性預設值為一般用途，目的是快速自動部署告警</p>
> <font color=red><h3>強烈建議</h3></font> 必須依據實際案場需要來調整各項監測屬性值，使用 Azure Portal Alert Rules 管理功能即可直接調整。
---
## 先決條件是已啟用 VM 診斷監測功能
> 準備工作：可以參考[由此處進入](https://github.com/mcloud-support/arm/tree/main/alert/vm/README.md)

## 輸出 Apache log 紀錄
1. 登入 VM 調整 OmsAgent 代理程式組態檔案，可參考[官方文件](https://github.com/microsoft/OMS-Agent-for-Linux/blob/master/docs/Apache-HTTP-Server-Logs-Collection.md)說明
2. 本處 Apache 紀錄檔的位置，須依照實際案場來修改想要收集的 Log Files Path，以下是說明：
   1. 先備妥 workspace ID
      > 前述執行 [ >> M-100-CreateWorkspace << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Fworkspace%2FM-100-CreateWorkspace.json) 後所產生的 workspace ID，登入 Azure Portal > Log Analytics workspaces > 「預設名稱為：mcloud-monitor-workspace」 > Overview 可查閱
   2.	登入已安裝 Apache 應用程式的 Virtual Machine
   3.	查看下列路徑是否存在代理程式組態檔案「apache_logs.conf」，若無，則複製 /etc/opt/microsoft/omsagent/<workspace id>/conf/omsagent.d/apache_logs.conf 
   4.	複製 apache_logs.conf 到下列位置
        ```
        sudo cp /etc/opt/microsoft/omsagent/sysconf/omsagent.d/apache_logs.conf /etc/opt/microsoft/omsagent/<change this workspace id>/conf/omsagent.d/

        sudo chown omsagent:omiusers /etc/opt/microsoft/omsagent/<change this workspace id>/conf/omsagent.d/apache_logs.conf
        ```

   5.	修改 apache_logs.conf 檔案內容，指定要收集的 Apache log 檔位置
        ```
        # Apache Access Log
        <source>
          ...
          path /usr/local/apache2/logs/access_log  #/var/log/apache2/access.log /var/log/httpd/access_log /var/log/apache2/access_log
          ...
        </source>

        # Apache Error Log
        <source>
          ...
          path /usr/local/apache2/logs/error_log  #/var/log/apache2/error.log /var/log/httpd/error_log /var/log/apache2/error_log
          ...
        </source>

        ```
   6.	Restart OMS Agent
        ```
        sudo /opt/microsoft/omsagent/bin/service_control restart 
        ```
   7.	Confirm that there are no errors in the OMS agent log
        ```
        sudo tail /var/opt/microsoft/omsagent/<change this workspace id>/log/omsagent.log 
        ```
   8.	進行確認 apache log 紀錄有收集到 Workspace，登入 Azure Portal 切換到該 Virtual Machines 管理 console > Monitoring > Logs，就可以看見 New Query1 的視窗，下面Tables > Custom Logs，出現 ApacheAccess_CL，如圖所示
<div align=center><img src="https://github.com/microsoft/OMS-Agent-for-Linux/raw/master/docs/pictures/ApacheHTTPServerSearchView.PNG?raw=true"></div>

## 建立 Apache 應用程式監控告警
1. 建立監控  Apache Linux VM 根磁碟或掛載磁碟的剩餘空間告警為例：
   * 執行先決條件是 VM 已經存在。
   * 點擊此處執行 ARM [ >> M-VM-01-FreeDiskSpace << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Falert%2FM-VM-01-FreeDiskSpace.json) 自動部署下列資源：
     * 建立 「Insufficient Disk Space」 alert rule
     * 配置告警觸發時傳送訊息到指定的 ActionGroup
2. 建立監控 Linux VM 根磁碟或掛載磁碟的剩餘空間告警為例：
   * 執行先決條件是 VM 已經存在。
   * 點擊此處執行 ARM [ >> M-VM-01-FreeDiskSpace << ](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmcloud-support%2Farm%2Fmain%2Falert%2FM-VM-01-FreeDiskSpace.json) 自動部署下列資源：
     * 建立 「Insufficient Disk Space」 alert rule
     * 配置告警觸發時傳送訊息到指定的 ActionGroup


[僅供MSP維運人員]

# 登入用戶端 Azure Portal
## 使用 Microsoft身分識別平台註冊 MCB Monitor 應用程式
> 此功能是讓用戶端 Azure 與 MCB Monitor應用程式產生信任關係，方能進行遠端調用監控資訊 </p>[Reference from Azure Docs](https://docs.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app)

---
## 1. 登入用戶端檢查目前執行身分的 Azure AD 權限設定
- 登入 Azure Portal，選擇 Azure Active Directory 管理功能。(注意目前使用的身分與角色，如果您的角色為 User，務必確定 non-administrators 可以操作登錄註冊應用程式的功能)
- 在左側功能表，選擇 User settings。
- 檢查應用程式登錄設定，這項功能可以設定為僅有 administrator 才能異動。也可以 any user in the Azure AD tenant can register an app.

## 2. 檢查訂閱權限設定
- 操作人員角色至少是訂閱的 Access Administrator role 或 Owner

## 3. 註冊 MCB Monitor 應用程式
> 註冊應用程式會在您的應用程式與 Microsoft 身分識別平台之間建立信任關係。 信任是單向的：您的應用程式會信任 Microsoft 身分識別平台，反之則不同。</p>
> 請依照這些步驟建立應用程式註冊：
- 登入 Azure [入口網站](https://portal.azure.com/) 
- 搜尋並選取 [Azure Active Directory] 
- 在 [管理]下選取 [應用程式註冊]，再選取 [新增註冊]。
- 輸入應用程式的 名稱
  - name: mon-mcloud-cht-com-tw
- 指定可以使用應用程式的人員，有時也稱為「登入受眾」
  - support account type: Accounts in this organizational directory only (xxx only - Single tenant)
- 設定重新導向 URI
  - 重新導向 URI: Web, https://mon.mcloud.cht.com.tw (可視環境的不同，修改此處網址)
- 設定完成後，<font color=yellow size=3>產生 Application (client) ID </font>與 <font color=yellow size=3>Directory (tenant) ID</font>，需儲存備用


## 4. 新增認證產生 MCB Monitor 應用程式用戶端密碼
- 在 Azure 入口網站的 應用程式註冊 中，選取上述應用程式 mon-mcloud-cht-com-tw
- 選取 Certificates & secrets.
- 選取 Client secrets -> New client secret.
  - 新增用戶端密碼的描述n : mon.mcloud.cht.com.tw
  - 選取持續時間 : Never
  - 選取 [新增] 
  - <font color=yellow size=3>記錄 Client secrets 產生的 Value (非ID)</font> 稍後需用於 MCB 用戶端監視服務功能設定 - <font color=yellow size=3>此值在您離開此頁面後就「不會再次顯示」，若忘記，僅能重新產生</font>

## 5. Expose an API (尚無法確定是否一定需要此步驟)
- 回到 [Azure Active Directory] 
- 在 [管理]下選取 [應用程式註冊]，在應用程式註冊 中，選取上述應用程式 mon-mcloud-cht-com-tw
- 選取 Expose an API
- 新增 scope
- Save and Continue
- Scope name : mcb-monitor-readonly
- Who can consent : Admins and users
- Admin consent display name : mcb-monitor-readonly
- Admin conset description : mcb-monitor-readonly
- 新增 scope

## 6. 指派角色給 MCB Monitor 應用程式
- 選擇 Subscriptions 功能管理頁面
- 選擇 Access control (IAM).
- 右側功能選擇 Add role assignment.
- Role 選擇 Contributor
- Select 輸入 mon-mcloud-cht-com-tw，點選出現的 member mon-mcloud-cht-com-tw 後儲存

## 7. 設定 MCB Monitor 應用程式存取的資源與功能
- 回到 [Azure Active Directory] 
- 在 [管理]下選取 [應用程式註冊]，在應用程式註冊 中，選取上述應用程式 mon-mcloud-cht-com-tw
- 選取左列管理的 API permissions
- (test)
- 新增一個 permission 選 My APIs.
- 選擇 mon-mcloud-cht-com-tw : Delegated permissions
- 選 APIs my organization uses
- , mcb-monitor-readonly, Read monitor relations as user
- 
- 新增一個 permission 選 APIs my organization uses
- 選擇下方 Log Analytics API 點擊進入設定
- 選擇 Delegated permissions
  - 勾選 Data.Read / Read Log Analytics data as user
- Add permissions 完成該項權限設定
- 依照上列方法，完成下列權限設定
  - Log Analytics API : Delegated permissions, Data.Read / Read Log Analytics data as user
  - 
# 以維運人員身分登入 MCB Monitor Portal 
## 1.設定 MCB Monitor 應用程式服務端資料來源
- 請先向 MCB Poratl Admin 確定您擁有管理 MCB Monitor Portal 的 Admin 權限
- 登入 MCB Monitor Portal，切換到用戶所分配的 Org Id
- 點選 MCB Monitor Portal 左側 Configuration 選擇新增 Data Source
- 在搜尋處輸入 Azure Monitor
- 選擇 Azure Monitor 之後，在 Azure Monitor Details 輸入前述程序紀錄的下列資訊
- Directory (tenant) ID
- Application (client) ID
- Client secret
- 按下 Load Subscriptions，選擇您要納管監控的 Subscription ID (一個 Monitor Data Source 對應一個 Subscription ID)
- 在 Azure Log Analytics API Details 資訊處
- 關閉 Same details as Azure Monitor API 按鈕
- 再次輸入 Directory (tenant) ID
- Application (client) ID
- Client secret
- 按下 Load Subscriptions，選擇您要納管監控的 Subscription ID
- 按下 Load Workspaces
- 會自動帶出先前在用戶端建立的 Workspace
- 按下 Save & Test ，出現成功訊息即完成設定
- 選擇 Back 離開

## 2.匯入基本儀錶板
- 點選 MCB Monitor Portal 左側 + 號，Create > Import 如下 ID
- Microsoft Azure Storage: 9962
- Azure Virtual Machine: 10532
- Azure Service Bus: 10533
- Azure Redis: 10534
- Azure PostgreSQL: 10535
- Azure MySQL: 10536
- Azure MongoDB: 10537
- Azure Event Hub: 10538
- DocumentDB / Cosmos DB: 10539
- Azure Data Lake Store Account: 10540
- Data factory factories: 10541
- Azure Monitor for Containers - Metrics: 10956
- AKS Container Insights: 12180
- Azure Windows Virtual Desktop Overview:12636
- AKS Monitor Container: 12817
- Azure Network Policy Dashboard based on Azure Monitor: 13102

## 3.(Option) 設定 MCB Monitor Alert轉發功能
- MCB Monitor platform 上新增 Alert Notificaiton Channels，設定Web Hook 填入回傳 MCB-RoutedIntoServiceBus Web hook Credentials String，即可整合傳送訊息到 MCB Portal

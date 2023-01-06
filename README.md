# Woding

SLOGAN - 一個提供快速訂位服務的餐廳網站

## 一、產品簡介

![image](/app/assets/images/home_page.png)
      
Woding，又名「我訂」，是致敬inline所開發出來的網站，我們提供消費者快速的餐廳訂位服務，消費者無需註冊、登入，就可以享有服務    


***


## 二、特色介紹

### **消費者端**
(1) 搜尋欄、標籤篩選 - 用SQL語法篩選出你想要找的關鍵字    
(2) 快速訂位 - 選擇日期、時間、位子類型即可定位  
(3) 無需註冊 - 不需註冊或者登入即可享受服務     
(4) 寄送信件 - 使用Action Mailer寄送完成訂位信件給使用者    
(5) Qrcode、QrcodeScanner - 消費者收到的信件裡面會附上一個QRcode.png，到店報到的時候，只要出示該QRCODE給店員掃描，即可快速帶位入座
(6) 簡訊提醒 - 使用twsms，完成訂單會順便寄送簡訊給消費者    
(7) Redis cache - 使用redis快取功能，避免使用者同一時間訂到重複的位子，Redis的Expire是設定300秒 

### **商家端**
(1) 瀏覽訂單、查詢訂單、歷史查詢
(2) 統整餐廳資訊，訂位狀況
(3) 自訂多個營業時段、休假日、用餐時間、訂位間隔時間
(4) 可上傳餐廳照片、菜單照片、自訂餐廳資訊
(5) 自訂座位型態、人數上限、座位訂金
(6) QR Code 報到，自動變更座位狀態
(7) 重要訂標記功能
***

三、成果DEMO
------

- DEMO Link：https://woding-5xruby-5.herokuapp.com/

## 四、技術Develop & Tools


- 前端：HTML / CSS、JavaScript、Ajax、Tailwind CSS、Stimulus JS
- 後端：Ruby On Rails
- 資料庫：PostgreSQL、Redis
- 部署：Heroku
- 版控： Git / GitHub

## 五、開發環境Environment

- Ruby 3.1.1
- Rails 6.1.7
- Database：postgreSQL

## 六、使用須知 Instructions

請於 clone 專案前依上述版本建置開發環境

***

### 步驟一：安裝套件
```shell
$ bundle install
$ yarn install
```
***
### 步驟二：建立資料庫
```shell
$ rails db:setup
```
***
### 步驟三：安裝redis

> --- 
> #### **這邊介紹一下homebrew**
>       
> Homebrew (brew) 是一個免費的開源包管理器
> 它允許根據用戶的需要在 macOS 中安裝應用程式和軟體。
> 推薦它是因為它的簡單性和節省時間和精力的有效性。
> 它的著名描述是“macOS 缺少的插件管理器”。
>   
> ---  
{: .block-tip}

因此我們用brew來安裝redis
```shell
$ brew install redis
```

***

### 步驟四：設定環境變數
git clone下來的時候，記得把env.example改成.env，並把自己申請的key加上去

#### 1、啟用寄/收信功能 - mailgun
```yaml
MAILGUN_DOMAIN=
MAILGUN_SMTP_LOGIN=
MAILGUN_SMTP_PASSWORD=
MAILGUN_SMTP_PORT=
MAILGUN_SMTP_SERVER=
```

#### 2、啟用金流功能 - MPG(藍新金流)
```yaml
MPG_ID=
MPG_KEY=
MPG_IV=
```

#### 3、啟用簡訊功能 - 台灣簡訊
```yaml
TWSMS_ACCOUNT=
TWSMS_PASSWORD=
```

#### 4、GoogleMap API
```yaml
GOOGLE_MAP_KEY=
```

#### 5、圖片上傳 - AWS S3
```yaml
ACCESS_KEY_ID=
SECRET_ACCESS_KEY=
```

#### 6、Domain - 自己的網域
```yaml
WEB_DOMAIN=
```

***

### 步驟五：開啟SERVER
```shell
foreman s
```

***

七、團隊 Member
------

* 陳登義 John Chen
  - Email: a034506618@gmail.com
  - GitHub: eagle0526
      
* 陳榮葦 Jeff Chen
  - Email: zen003266598@gmail.com
  - GitHub: zen006598   


* 呂宣銘 Mike LU
  - Email: Mik0833695466@gmail.com
  - GitHub: MrMikeMing

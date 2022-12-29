# README

* 拉下檔案的時候，記得把.env.example改成.env，並把自己的環境變數加上去
* (1) .env.example 加入你的mail gun 資料，已完成寄信功能
* (2) 加上完成訂單的mail，使用的時候，記得把你自己的mailgun資料填進.env的檔案
* (3) 如果今天有使用到金流系統，此檔案使用的是藍新金流，記得把env中的三個參數換成自己商店的key
* (4) 我們是使用台灣簡訊，如果想要寄簡訊，記得申請一組台灣簡訊的帳號、密碼
* (5) 為了過AWS S3 驗證，下面兩個KEY要記得加上去
      檔案內新增加入(1)ACCESS_KEY_ID=貼上ID
      檔案內新增加入(2)SECRET_ACCESS_KEY=貼上key
* (6) 我們訂位系統有使用redis，因此拉下來的時候，記得安裝redis -> brew install redis
* (7) GoogleAPI要使用的話，必須要去申請一個KEY

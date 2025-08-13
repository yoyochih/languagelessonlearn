-- Day24 Logging Config 參考解答
-- 說明：日誌等級、參數化、設定檔管理

-- 1. 簡易 logger
local Logger={{}}; Logger.__index=Logger; function Logger.new(level) return setmetatable({{level=level or "INFO"}}, Logger) end; function Logger:log(l,msg) if l>=self.level then print(l, msg) end end; local L=Logger.new("INFO"); L:log("INFO","hello")

-- 2. 讀設定表
local cfg={{level="DEBUG",path="./app.log"}}; for k,v in pairs(cfg) do print(k,v) end

-- 3. 加上時間戳
local function ts() return os.date("%Y-%m-%d %H:%M:%S") end; print(ts(), "message")

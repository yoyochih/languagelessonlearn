-- Day26 Refactoring 參考解答
-- 說明：模組化與檔案佈局，將前日 CLI 重構

-- 1. 抽出 util.lua
-- util.lua
local M={{}}; function M.splitKV(a) return a:match("([^=]+)=(.*)") end; return M

-- 2. 主程式 require util
local util=require("util"); local t={{}}; for _,a in ipairs(arg) do local k,v=util.splitKV(a); if k then t[k]=v end end; for k,v in pairs(t) do print(k,v) end

-- 3. 小結
print("refactor done")

-- Day25 CLI Tools 參考解答
-- 說明：封裝成簡易 CLI：--help 與參數解析（簡化版）

-- 1. --help
local function usage() print("usage: lua tool.lua --name=XXX") end; local name; for _,a in ipairs(arg) do name = name or a:match("%-%-name=(.*)") end; if not name then usage() os.exit(1) end; print("Hi", name)

-- 2. 解析 key=value 參數
local args={{}}; for _,a in ipairs(arg) do local k,v=a:match("([^=]+)=(.*)"); if k then args[k]=v end end; for k,v in pairs(args) do print(k,v) end

-- 3. 錯誤碼
os.exit(2)

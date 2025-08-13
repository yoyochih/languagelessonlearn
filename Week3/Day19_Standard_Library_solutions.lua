-- Day19 Standard Library 參考解答
-- 說明：標準庫概覽：math, os, debug

-- 1. math 基本
print(math.floor(3.7), math.max(1,9))

-- 2. os 時間
print(os.date("%Y-%m-%d %H:%M:%S"))

-- 3. debug.traceback
local function f() return debug.traceback("where?") end; print(f())

-- Day6 Strings 參考解答
-- 說明：字串處理與模式匹配

-- 1. 分割字串
local s="a,b,c"; local out={{}}; for w in s:gmatch("[^,]+") do out[#out+1]=w end; for i=1,#out do print(out[i]) end

-- 2. 大小寫與格式化
local s="Lua"; print(s:lower(), s:upper(), string.format("Hi %s %d", s, 2025))

-- 3. 簡單模式匹配擷取數字
local s="id=42; x=7"; for d in s:gmatch("%d+") do print(d) end

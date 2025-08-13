-- Day20 Testing 參考解答
-- 說明：最小測試框架/斷言

-- 1. 簡易斷言
local function assert_eq(a,b,msg) if a~=b then error(msg or (tostring(a).."~="..tostring(b))) end end; assert_eq(2+3,5)

-- 2. 測試 map
local function map(t,f) local r={{}}; for i,v in ipairs(t) do r[i]=f(v) end; return r end; local r=map({{1,2}}, function(x) return x*3 end); assert(r[1]==3 and r[2]==6)

-- 3. 報告總結
print("All tests passed!")

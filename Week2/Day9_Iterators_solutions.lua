-- Day9 Iterators 參考解答
-- 說明：泛型 for、自訂迭代器、pairs/ipairs

-- 1. 比較 pairs 與 ipairs
local t={{10,20,a=30}}; for k,v in pairs(t) do print("pairs",k,v) end; for i,v in ipairs(t) do print("ipairs",i,v) end

-- 2. 自訂 from..to 迭代器
local function fromto(a,b) local i=a-1; return function() i=i+1; if i<=b then return i end end end;
for v in fromto(3,6) do print(v) end

-- 3. 逐字元迭代
local s="lua"; local i=0; local function chars() i=i+1; return s:sub(i,i) ~= "" and s:sub(i,i) or nil end; for c in chars do print(c) end

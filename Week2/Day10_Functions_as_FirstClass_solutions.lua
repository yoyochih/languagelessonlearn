-- Day10 Functions as FirstClass 參考解答
-- 說明：高階函式：map/filter/reduce

-- 1. map *2
local function map(t,f) local r={{}}; for i,v in ipairs(t) do r[i]=f(v) end; return r end; local t=map({{1,2,3}}, function(x) return x*2 end); for i=1,#t do print(t[i]) end

-- 2. filter 偶數
local function filter(t,p) local r={{}}; for _,v in ipairs(t) do if p(v) then r[#r+1]=v end end; return r end; local t=filter({{1,2,3,4}}, function(x) return x%2==0 end); for i=1,#t do print(t[i]) end

-- 3. reduce 求和
local function reduce(t,f,acc) for _,v in ipairs(t) do acc=f(acc,v) end; return acc end; local s=reduce({{1,2,3}}, function(a,b) return a+b end, 0); print(s)

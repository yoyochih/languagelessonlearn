-- Day27 Benchmarking 參考解答
-- 說明：基準測試與簡易剖析

-- 1. 對比兩種串接策略
local function join_concat(n) local t={{}}; for i=1,n do t[i]=tostring(i) end; return table.concat(t,",") end
local function join_plus(n) local s=""; for i=1,n do s=s..i.."," end; return s end
local t=os.clock(); join_concat(20000); print("concat", os.clock()-t); t=os.clock(); join_plus(20000); print("plus", os.clock()-t)

-- 2. 微基準工具
local function bench(fn, n) local t=os.clock(); for i=1,n do fn() end; return os.clock()-t end; print(bench(function() return math.sqrt(123.456) end, 1e5))

-- 3. 熱點觀察（概念示例）
print("使用外部 profiler/工具時，先鎖定最常呼叫/最慢的函式")

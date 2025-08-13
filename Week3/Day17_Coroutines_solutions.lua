-- Day17 Coroutines 參考解答
-- 說明：協程：生產者/消費者、生成器

-- 1. 基本 coroutine
local co = coroutine.create(function() for i=1,3 do coroutine.yield(i*i) end end); local ok,v=coroutine.resume(co); while ok and v do print(v); ok,v=coroutine.resume(co) end

-- 2. 檔案逐行生成器
local function lines(path) return coroutine.wrap(function() for line in assert(io.open(path,"r")):lines() do coroutine.yield(line) end end) end; for l in lines("README.md") do print(l) end

-- 3. 合併兩個已排序串流
local function gen(t) return coroutine.wrap(function() for i=1,#t do coroutine.yield(t[i]) end end) end
local a,b=gen({{1,3,5}}), gen({{2,4,6}})
local x,y=a(),b(); while x or y do if not y or (x and x<=y) then print(x); x=a() else print(y); y=b() end end

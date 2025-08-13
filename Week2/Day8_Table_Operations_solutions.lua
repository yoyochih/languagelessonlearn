-- Day8 Table Operations 參考解答
-- 說明：插入、刪除、排序、淺拷貝

-- 1. 排序數列
local t={{5,1,4,2}}; table.sort(t); for i=1,#t do print(t[i]) end

-- 2. 淺拷貝
local function clone(a) local b={{}}; for k,v in pairs(a) do b[k]=v end; return b end; local x={{a=1}}; local y=clone(x); print(y.a)

-- 3. 移除元素
local t={{"x","y","z"}}; table.remove(t,2); for i=1,#t do print(t[i]) end

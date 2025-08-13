-- Day18 Performance 參考解答
-- 說明：效能與記憶體：避免分配、upvalue、預先表容量

-- 1. 避免重複連接字串
local parts={{}}; for i=1,1000 do parts[i]=tostring(i) end; local s=table.concat(parts," "); print(#s>0)

-- 2. upvalue 快取全域
local math_sqrt = math.sqrt; local s=0; for i=1,1e5 do s=s+math_sqrt(i) end; print(s>0)

-- 3. 預先配置表
local t={{}}; for i=1,1000 do t[i]=false end; print(#t)

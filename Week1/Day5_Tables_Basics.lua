-- Day5 Tables Basics
-- 說明：表(table) 作為陣列/字典

-- 範例：
print("Hello from Day5_Tables_Basics")

-- 練習：
-- 1. 建立數列並印長度
-- local t = {{1,2,3}}; print(#t) t 是一個包含單個元素的表格 這個元素本身是一個表格 {1,2,3} --所以 t 的結構是：t = { [1] = {1,2,3} }
--#t 計算的是最外層表格 t 的長度 這個表格只有 1 個元素（索引 1 的位置） 所以 #t 返回 1
local t = {{1,2,3}}; print(#t[1])
--local t = {{1,2,3}}; print(#t[1])  -- 這才是獲取內部表格長度的正確寫法，輸出 3


-- 2. 字典風格表並取值
-- local person={name="Ana", age=20}; print(person.name, person.age)
local person={name="Ana", age=20}; print(person.name, person.age)

-- 3. 混合表與遍歷
-- local t={{"a", "b", key=42}}; for k,v in pairs(t) do print(k,v) end
local t={"a", "b", key=42 }; for k,v in pairs(t) do print(k,v) end

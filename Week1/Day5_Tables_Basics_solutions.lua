-- Day5 Tables Basics 參考解答
-- 說明：表(table) 作為陣列/字典

-- 1. 建立數列並印長度
local t = {{1,2,3}}; print(#t)

-- 2. 字典風格表並取值
local person={{name="Ana", age=20}}; print(person.name, person.age)

-- 3. 混合表與遍歷
local t={{"a", "b", key=42}}; for k,v in pairs(t) do print(k,v) end

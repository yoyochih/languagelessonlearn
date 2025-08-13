-- Day4 Functions and Closures 參考解答
-- 說明：函式、可變參數、閉包

-- 1. 寫 add(a,b) 回傳和
local function add(a,b) return a+b end; print(add(2,3))

-- 2. 可變參數求和
local function sum(...) local s=0; for _,v in ipairs({...}) do s=s+v end; return s end; print(sum(1,2,3))

-- 3. 閉包計數器
local function counter() local c=0; return function() c=c+1; return c end end; local c=counter(); print(c(), c())

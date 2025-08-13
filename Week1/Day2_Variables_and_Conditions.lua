-- Day2 Variables and Conditions
-- 說明：變數/區域性(local)、條件 if/elseif/else、比較與邏輯

-- 範例：
--print("Hello from Day2_Variables_and_Conditions")

-- 練習：
-- 1. 使用 local 變數儲存分數，判斷等第
--local score=86; if score>=90 then print("A") elseif score>=80 then print("B") else print("C") end
local score=91; if score>=90 then print("A") elseif score>=80 then print("B") else print("C") end

-- 2. 比較兩個數字大小並印出較大值
-- local a,b=10,7; if a>b then print(a) else print(b) end
local a,b=10,7; if a>b then print(a) else print(b) end

-- 3. 練習布林邏輯與非 0 判定
-- local x=nil; print(x and "T" or "F"); x=0; print(x and "T" or "F")
local x=nil; print(x and "T" or "F"); x=0; print(x and "T" or "F")

--Lua 只有 nil 和 false 被視為「假」，0、""（空字串）等都是「真」。
--x and "T" or "F" 是 Lua 中常見的三元運算符替代寫法（類似 C 的 x ? "T" : "F"）
--Lua 的邏輯運算規則

--運算符	 行為
--a and b	如果 a 是 false 或 nil，返回 a，否則返回 b
--a or b	如果 a 是 false 或 nil，返回 b，否則返回 a
--not a	    總是返回 true 或 false（與 and/or 不同）


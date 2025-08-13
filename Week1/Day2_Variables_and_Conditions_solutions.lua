-- Day2 Variables and Conditions 參考解答
-- 說明：變數/區域性(local)、條件 if/elseif/else、比較與邏輯

-- 1. 使用 local 變數儲存分數，判斷等第
local score=86; if score>=90 then print("A") elseif score>=80 then print("B") else print("C") end

-- 2. 比較兩個數字大小並印出較大值
local a,b=10,7; if a>b then print(a) else print(b) end

-- 3. 練習布林邏輯與非 0 判定
local x=nil; print(x and "T" or "F"); x=0; print(x and "T" or "F")

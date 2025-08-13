-- Day3 Loops 參考解答
-- 說明：for/while/repeat…until 迴圈

-- 1. for 1..5 相加
local s=0; for i=1,5 do s=s+i end; print(s)

-- 2. while 印出 1..3
local i=1; while i<=3 do print(i); i=i+1 end

-- 3. repeat…until 直到輸入為 q
local input; repeat input=io.read() until input=="q"; print("bye")

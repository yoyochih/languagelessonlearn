-- Day6 Strings
-- 說明：字串處理與模式匹配

-- 範例：
print("Hello from Day6_Strings")

-- 練習：
-- 1. 分割字串
-- local s="a,b,c"; local out={}; for w in s:gmatch("[^,]+") do out[#out+1]=w end; for i=1,#out do print(out[i]) end
local s="a,b,c"; local out={}; for w in s:gmatch("[^,]+") do out[#out+1]=w end; for i=1,#out do print(out[i]) end

-- 2. 大小寫與格式化
-- local s="Lua"; print(s:lower(), s:upper(), string.format("Hi %s %d", s, 2025))
local s="Lua"; print(s:lower(), s:upper(), string.format("Hi %s %d", s, 2025))

-- 3. 簡單模式匹配擷取數字
-- local s="id=42; x=7"; for d in s:gmatch("%d+") do print(d) end
local s="id=42; x=7"; for d in s:gmatch("%d+") do print(d) end


-- 模式匹配 %d+：
-- %d 匹配任何數字（0-9）
-- + 表示「一個或多個」前導字元
-- %d+ 會匹配連續的數字串
-- gmatch 方法：
-- 返回一個迭代器函數
-- 每次呼叫會返回下一個匹配的數字串
-- 自動處理所有匹配項
-- 執行流程：
-- 第一次匹配到 "42"（來自 "id=42"）
-- 第二次匹配到 "7"（來自 "x=7"）
-- 沒有更多數字時循環結束

-- 提取特定規格得數字(只提取x=後面的數字)

local s = "id=42; x=7" for d in s:gmatch("x=(%d+)") do print(d) end

local s = "id=42; x=7" for d in s:gmatch("(?<=x=)%d+") do  -- 需 Lua 5.3 以上
      print(d)  -- 輸出: 7
end
-- 處理浮點數
local s = "a=1.5; x=3.14"
for d in s:gmatch("x=(%d+%.?%d*)") do
    print(d)  -- 輸出: 3.14
end
--提取多個x= 值
local s = "x=1, y=2, x=3"
for d in s:gmatch("x=(%d+)") do
    print(d)  -- 輸出: 1 和 3（分兩行）
end

--安全處理無匹派情況
local s = "id=42; y=7"
local found = false
for d in s:gmatch("x=(%d+)") do
    print(d)
    found = true
end
if not found then
    print("未找到 x= 的數字")
end

-- 目標	原始模式	修改後模式
-- 所有數字	%d+	%d+
-- 僅 x= 後的數字	%d+	x=(%d+)

--Q: 若 x= 後面有空格怎麼辦？
--A: 調整模式為 x=%s*(%d+)，其中 %s* 匹配 0 個或多個空格：
local s = "x=   42"
for d in s:gmatch("x=%s*(%d+)") do
    print(d)  -- 輸出: 42
end

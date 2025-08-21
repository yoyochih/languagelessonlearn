-- Day10 Functions as FirstClass
-- 說明：高階函式：map/filter/reduce

-- 範例：
print("Hello from Day10_Functions_as_FirstClass")

-- 練習：
-- 1. map *2
local function map(t, f)
    local result = {}
    for i, v in ipairs(t) do
        result[i] = f(v)  -- 對每個元素 v 執行函數 f
    end
    return result
end

-- 測試：把每個數字乘以 2
local numbers = {1, 2, 3, 4, 5}
local doubled = map(numbers, function(x) return x * 2 end)

print("map 範例（每個數字 * 2）：")
for _, v in ipairs(doubled) do print(v) end

-- 2. filter 偶數
local function filter(t, f)
    local result = {}
    for _, v in ipairs(t) do
        if f(v) then         -- 如果條件成立（f(v) 回傳 true）
            table.insert(result, v)  -- 把元素加入新列表
        end
    end
    return result
end

-- 測試：只保留偶數
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
local evens = filter(numbers, function(x) return x % 2 == 0 end)

print("\nfilter 範例（只保留偶數）：")
for _, v in ipairs(evens) do print(v) end

-- 3. reduce 求和
local function reduce(t, f, initial)
    local accumulator = initial
    for _, v in ipairs(t) do
        if accumulator == nil then
            accumulator = v  -- 如果沒給初始值，第一個元素當初始值
        else
            accumulator = f(accumulator, v)  -- 累積計算
        end
    end
    return accumulator
end

-- 測試：計算數字的總和
local sum = reduce(numbers, function(a, b) return a + b end, 0)

print("\nreduce 範例（計算總和）：", sum)

--函數	     功能	          範例用途
--map	    對每個元素做轉換	數字加倍、字串轉大寫
--filter	篩選符合條件的元素	保留偶數、過濾空值
--reduce	把列表壓縮成單一值	計算總和、找最大值
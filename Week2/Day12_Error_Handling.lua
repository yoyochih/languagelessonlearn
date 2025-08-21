-- Day12 Error Handling
-- 說明：pcall/xpcall、錯誤流程

-- 範例：
print("Hello from Day12_Error_Handling")

-- 練習：錯誤處理 (pcall, xpcall, traceback)

print("=== 錯誤處理練習 ===")

-- 1. pcall 包裝可能失敗的函式
print("\n1. pcall 基本用法:")
local function risky(x)
    if x < 0 then
        error("x 不能為負數，收到: " .. x)
    end
    return math.sqrt(x)
end

-- 測試成功的情況
local ok1, res1 = pcall(risky, 16)
print("risky(16) - 成功:", ok1, "結果:", res1)  -- true, 4

-- 測試失敗的情況
local ok2, res2 = pcall(risky, -1)
print("risky(-1) - 成功:", ok2, "錯誤:", res2)  -- false, 錯誤訊息

-- 2. xpcall 與 traceback
print("\n2. xpcall 與錯誤處理器:")
local function error_handler(err)
    print("=== 錯誤處理器被呼叫 ===")
    print("錯誤訊息:", err)
    print("堆疊追蹤:")
    print(debug.traceback("追蹤資訊:", 2))
    print("=== 錯誤處理結束 ===")
    return "已處理的錯誤: " .. err
end

local function dangerous_operation()
    local random_value = math.random(1, 10)
    if random_value > 7 then
        error("隨機值 " .. random_value .. " 太大！")
    end
    return "操作成功，值: " .. random_value
end

-- 使用 xpcall
local success, result = xpcall(dangerous_operation, error_handler)
print("操作結果 - 成功:", success, "回傳值:", result)

-- 3. 安全 IO 包裝
print("\n3. 安全的檔案操作包裝:")
local function safe_file_open(filepath, mode)
    mode = mode or "r"
    local ok, file_handle_or_error = pcall(io.open, filepath, mode)
    
    if not ok then
        return nil, "開啟檔案失敗: " .. file_handle_or_error
    end
    
    if not file_handle_or_error then
        return nil, "無法開啟檔案: " .. filepath
    end
    
    return file_handle_or_error
end

local function safe_file_read(filepath)
    local file, err = safe_file_open(filepath)
    if not file then
        return nil, err
    end
    
    -- 使用 pcall 包裝讀取操作
    local ok, content_or_error = pcall(function()
        local content = file:read("*a")
        file:close()
        return content
    end)
    
    if not ok then
        file:close()
        return nil, "讀取失敗: " .. content_or_error
    end
    
    return content_or_error
end

-- 測試安全檔案操作
print("測試讀取存在的檔案:")
local content, err = safe_file_read("Day11_Modules.lua")  -- 讀取自己
if content then
    print("檔案讀取成功，長度:", #content, "位元組")
else
    print("讀取失敗:", err)
end

print("\n測試讀取不存在的檔案:")
local content2, err2 = safe_file_read("nonexistent_file.txt")
if not content2 then
    print("預期的失敗:", err2)
end

-- 4. 進階範例：安全數學計算
print("\n4. 安全數學計算器:")
local function safe_calculator(operation, ...)
    local operations = {
        add = function(a, b) return a + b end,
        subtract = function(a, b) return a - b end,
        multiply = function(a, b) return a * b end,
        divide = function(a, b)
            if b == 0 then
                error("除數不能為零")
            end
            return a / b
        end,
        power = function(a, b) return a ^ b end
    }
    
    local func = operations[operation]
    if not func then
        return nil, "不支援的操作: " .. tostring(operation)
    end
    
    local ok, result = pcall(func, ...)
    if not ok then
        return nil, "計算錯誤: " .. result
    end
    
    return result
end

-- 測試安全計算器
local test_cases = {
    {"add", 10, 5},
    {"subtract", 10, 5},
    {"multiply", 10, 5},
    {"divide", 10, 2},
    {"divide", 10, 0},  -- 會失敗
    {"power", 2, 3},
    {"unknown", 1, 2}   -- 會失敗
}

for i, case in ipairs(test_cases) do
    local op, a, b = table.unpack(case)  -- Lua 5.4 的正確用法
    local result, err = safe_calculator(op, a, b)
    
    if result then
        print(string.format("%d %s %d = %s", a, op, b, result))
    else
        print(string.format("%d %s %d - 錯誤: %s", a, op, b, err))
    end
end

print("\n=== 錯誤處理練習完成 ===")

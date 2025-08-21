-- Day11 Modules
-- 說明：模組與 require、專案結構

-- 範例：
print("Hello from Day11_Modules")

-- 練習：
-- 1. 建立模組並匯入
-- 定義 mathx 模組（直接寫在同一個檔案中測試
local mathx_module = {}
function mathx_module.square(x)
    return x * x
end

function mathx_module.cube(x)
    return x * x * x
end

-- 2. 使用 mathx 模組
print("9 的平方:", mathx_module.square(9))  -- 輸出: 81
print("5 的平方:", mathx_module.square(5))  -- 輸出: 25
print("3 的立方:", mathx_module.cube(3))    -- 輸出: 27


-- 2. 主程式使用模組




-- 3. 封裝與 local 範例
local function create_secret_module()
    local M = {}
    local secret = 7  -- 私有變數

    function M.get_secret()
        return secret
    end

    function M.set_secret(new_value)
        secret = new_value
    end

    function M.double_secret()
        return secret * 2
    end

    return M
end

-- 使用封裝模組
print("\n=== 封裝測試 ===")
local secret_mod = create_secret_module()
print("當前秘密值:", secret_mod.get_secret())      -- 輸出: 7
print("秘密的兩倍:", secret_mod.double_secret())   -- 輸出: 14

secret_mod.set_secret(10)
print("修改後的秘密值:", secret_mod.get_secret())  -- 輸出: 10
print("新的兩倍值:", secret_mod.double_secret())   -- 輸出: 20

-- 4. 計數器模組範例
local function create_counter()
    local M = {}
    local count = 0  -- 私有變數

    function M.increment()
        count = count + 1
        return count
    end

    function M.decrement()
        count = count - 1
        return count
    end

    function M.get_count()
        return count
    end

    function M.reset()
        count = 0
        return count
    end

    return M
end


-- 使用計數器模組
print("\n=== 計數器測試 ===")
local counter = create_counter()
print("初始值:", counter.get_count())  -- 輸出: 0

counter.increment()
counter.increment()
print("增加兩次後:", counter.get_count())  -- 輸出: 2

counter.decrement()
print("減少一次後:", counter.get_count())  -- 輸出: 1

counter.reset()
print("重置後:", counter.get_count())  -- 輸出: 0

print("\n=== 練習完成 ===")

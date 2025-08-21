-- Day13 File IO
-- 說明：讀寫檔案、table.concat、序列化概念

print("Hello from Day13_File_IO")

-- 設置輸入和輸出文件名
local input_file = "input.txt"
local output_file = "output.txt"

-- 1. 讀檔與寫檔
print("\n1. 文件讀寫操作:")
-- 寫入文件
local file_out = io.open(output_file, "w")
if file_out then
    file_out:write("第一行內容\n")
    file_out:write("第二行內容\n")
    file_out:write("第三行內容\n")
    file_out:close()
    print("已寫入文件: " .. output_file)
else
    print("無法寫入文件: " .. output_file)
end

-- 讀取文件
local file_in = io.open(output_file, "r")
if file_in then
    print("文件內容:")
    for line in file_in:lines() do
        print("  " .. line)
    end
    file_in:close()
else
    print("無法讀取文件: " .. output_file)
end

-- 2. table.concat
print("\n2. table.concat 使用:")
local fruits = {"蘋果", "香蕉", "橙子", "葡萄"}
print("表格內容: ", table.concat(fruits, ", "))

local numbers = {1, 2, 3, 4, 5}
print("數字連接: ", table.concat(numbers, " - "))

-- 3. 簡易序列化
print("\n3. 簡易序列化:")
local function serialize(t)
    local result = "{"
    for k, v in pairs(t) do
        if type(k) == "number" then
            result = result .. string.format("[%s] = ", k)
        else
            result = result .. string.format("[\"%s\"] = ", k)
        end
        
        if type(v) == "string" then
            result = result .. string.format("\"%s\", ", v)
        else
            result = result .. string.format("%s, ", tostring(v))
        end
    end
    result = result:sub(1, -3) .. "}" -- 移除最後的逗號和空格
    return result
end

local sample_table = {
    name = "Lua程式",
    version = 5.3,
    features = {"簡單", "高效", "可嵌入"},
    year = 1993
}

print("序列化結果:")
print(serialize(sample_table))

-- 等待用戶輸入後退出
print("\n按 Enter 鍵退出...")
io.read()
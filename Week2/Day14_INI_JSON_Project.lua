-- Day14_INI_JSON_Project.lua
-- 說明：小專案：INI/JSON 讀寫合併（簡化版）

print("Hello from Day14_INI_JSON_Project")

-- 1. 簡易 INI parser（支援段落、key=value）
local function parse_ini(path)
    local config = {}
    local current_section = "default"
    config[current_section] = {}
    
    local file, err = io.open(path, "r")
    if not file then
        return nil, "無法開啟文件: " .. err
    end
    
    for line in file:lines() do
        -- 移除前後空白和註解
        line = line:match("^%s*(.-)%s*$"):match("([^#]*)")
        if line ~= "" then
            -- 檢查是否為段落
            local section = line:match("^%[([^%]]+)%]$")
            if section then
                current_section = section:lower()
                config[current_section] = config[current_section] or {}
            else
                -- 解析 key=value
                local key, value = line:match("^%s*([^=]+)%s*=%s*(.-)%s*$")
                if key and value then
                    key = key:match("^%s*(.-)%s*$"):lower()
                    value = value:match("^%s*(.-)%s*$")
                    
                    -- 嘗試轉換數字和布林值
                    if value == "true" then
                        value = true
                    elseif value == "false" then
                        value = false
                    elseif tonumber(value) then
                        value = tonumber(value)
                    end
                    
                    config[current_section] = config[current_section] or {}
                    config[current_section][key] = value
                end
            end
        end
    end
    
    file:close()
    return config
end

-- 2. 簡易 JSON parser（基本功能）
local function parse_json(path)
    local file, err = io.open(path, "r")
    if not file then
        return nil, "無法開啟文件: " .. err
    end
    
    local content = file:read("*a")
    file:close()
    
    -- 簡化的 JSON 解析（僅處理基本結構）
    content = content:gsub("//[^\n]*", ""):gsub("/%*.-%*/", "") -- 移除註解
    
    local function parse_value(str, pos)
        pos = pos or 1
        while pos <= #str and str:sub(pos, pos):match("%s") do
            pos = pos + 1
        end
        
        local char = str:sub(pos, pos)
        if char == "{" then
            return parse_object(str, pos)
        elseif char == "[" then
            return parse_array(str, pos)
        elseif char == '"' then
            return parse_string(str, pos)
        elseif char:match("%d") or char == "-" then
            return parse_number(str, pos)
        elseif str:sub(pos, pos + 3) == "true" then
            return true, pos + 4
        elseif str:sub(pos, pos + 4) == "false" then
            return false, pos + 5
        elseif str:sub(pos, pos + 3) == "null" then
            return nil, pos + 4
        end
        return nil, pos
    end

    local function parse_object(str, pos)
        local obj = {}
        pos = pos + 1
        
        while pos <= #str do
            while str:sub(pos, pos):match("%s") do
                pos = pos + 1
            end
            
            if str:sub(pos, pos) == "}" then
                return obj, pos + 1
            end
            
            local key, new_pos = parse_string(str, pos)
            if not key then
                break
            end
            
            pos = new_pos
            while str:sub(pos, pos):match("%s") do
                pos = pos + 1
            end
            
            if str:sub(pos, pos) ~= ":" then
                break
            end
            
            pos = pos + 1
            local value, new_pos = parse_value(str, pos)
            if not value then
                break
            end
            
            obj[key] = value
            pos = new_pos
            
            while str:sub(pos, pos):match("%s") do
                pos = pos + 1
            end
            
            if str:sub(pos, pos) == "," then
                pos = pos + 1
            elseif str:sub(pos, pos) == "}" then
                return obj, pos + 1
            end
        end
        return obj, pos
    end

    local function parse_array(str, pos)
        local arr = {}
        pos = pos + 1
        
        while pos <= #str do
            while str:sub(pos, pos):match("%s") do
                pos = pos + 1
            end
            
            if str:sub(pos, pos) == "]" then
                return arr, pos + 1
            end
            
            local value, new_pos = parse_value(str, pos)
            if not value then
                break
            end
            
            table.insert(arr, value)
            pos = new_pos
            
            while str:sub(pos, pos):match("%s") do
                pos = pos + 1
            end
            
            if str:sub(pos, pos) == "," then
                pos = pos + 1
            elseif str:sub(pos, pos) == "]" then
                return arr, pos + 1
            end
        end
        return arr, pos
    end

    local function parse_string(str, pos)
        if str:sub(pos, pos) ~= '"' then
            return nil, pos
        end
        
        pos = pos + 1
        local result = ""
        
        while pos <= #str do
            local char = str:sub(pos, pos)
            if char == '"' then
                return result, pos + 1
            elseif char == "\\" then
                pos = pos + 1
                local escape = str:sub(pos, pos)
                if escape == "n" then
                    result = result .. "\n"
                elseif escape == "t" then
                    result = result .. "\t"
                else
                    result = result .. escape
                end
            else
                result = result .. char
            end
            pos = pos + 1
        end
        return nil, pos
    end

    local function parse_number(str, pos)
        local start_pos = pos
        while pos <= #str and (str:sub(pos, pos):match("%d") or str:sub(pos, pos) == "." or str:sub(pos, pos) == "-" or str:sub(pos, pos) == "e" or str:sub(pos, pos) == "E") do
            pos = pos + 1
        end
        local num_str = str:sub(start_pos, pos - 1)
        return tonumber(num_str), pos
    end

    local result, pos = parse_value(content)
    return result
end

-- 3. 合併配置
local function merge_configs(config1, config2)
    local merged = {}
    
    -- 複製第一個配置
    for section, values in pairs(config1) do
        merged[section] = {}
        for key, value in pairs(values) do
            merged[section][key] = value
        end
    end
    
    -- 合併第二個配置（覆蓋相同鍵值）
    for section, values in pairs(config2) do
        merged[section] = merged[section] or {}
        for key, value in pairs(values) do
            merged[section][key] = value
        end
    end
    
    return merged
end

-- 4. 輸出配置
local function write_config(config, format, path)
    if format:lower() == "ini" then
        local file, err = io.open(path, "w")
        if not file then
            return false, "無法寫入文件: " .. err
        end
        
        for section, values in pairs(config) do
            if section ~= "default" or not next(values) then
                file:write("[" .. section .. "]\n")
            end
            for key, value in pairs(values) do
                if type(value) == "boolean" then
                    value = value and "true" or "false"
                end
                file:write(key .. " = " .. tostring(value) .. "\n")
            end
            file:write("\n")
        end
        
        file:close()
        return true
    else
        return false, "不支援的輸出格式"
    end
end

-- 主程式
local function main()
    -- 讀取命令行參數
    local file1 = arg[1] or "config_a.ini"
    local file2 = arg[2] or "config_b.ini"
    local output_file = arg[3] or "merged_config.ini"
    
    print("合併配置檔案:")
    print("檔案1: " .. file1)
    print("檔案2: " .. file2)
    print("輸出: " .. output_file)
    print()
    
    -- 解析檔案
    local config1, err1
    if file1:match("%.ini$") then
        config1, err1 = parse_ini(file1)
    elseif file1:match("%.json$") then
        config1 = parse_json(file1)
    else
        print("錯誤: 不支援的檔案格式 - " .. file1)
        os.exit(1)
    end
    
    if not config1 then
        print("錯誤: 無法解析 " .. file1 .. " - " .. err1)
        os.exit(1)
    end
    
    local config2, err2
    if file2:match("%.ini$") then
        config2, err2 = parse_ini(file2)
    elseif file2:match("%.json$") then
        config2 = parse_json(file2)
    else
        print("錯誤: 不支援的檔案格式 - " .. file2)
        os.exit(1)
    end
    
    if not config2 then
        print("錯誤: 無法解析 " .. file2 .. " - " .. err2)
        os.exit(1)
    end
    
    -- 合併配置
    local merged = merge_configs(config1, config2)
    
    -- 輸出合併結果
    local success, err = write_config(merged, "ini", output_file)
    if not success then
        print("錯誤: 無法寫入輸出檔案 - " .. err)
        os.exit(1)
    end
    
    print("合併完成！")
    print("合併後的配置:")
    for section, values in pairs(merged) do
        print("[" .. section .. "]")
        for key, value in pairs(values) do
            print("  " .. key .. " = " .. tostring(value))
        end
    end
end

-- 執行主程式
main()
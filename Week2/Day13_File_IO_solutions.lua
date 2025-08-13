-- Day13 File IO 參考解答
-- 說明：讀寫檔案、table.concat、序列化概念

-- 1. 讀檔與寫檔
local inp="input.txt"; local out="output.txt"; local f=io.open(out,"w"); f:write("hello\n"); f:close(); local g=io.open(out,"r"); for line in g:lines() do print(line) end; g:close()

-- 2. table.concat
local t={{"a","b","c"}}; print(table.concat(t, ","))

-- 3. 簡易序列化
local function serialize(t)
  local parts={{"{"}}; for k,v in pairs(t) do parts[#parts+1]=string.format("[%q]=%q,", k, tostring(v)) end; parts[#parts+1]="}"; return table.concat(parts) end
print(serialize({{a=1,b="x"}}))

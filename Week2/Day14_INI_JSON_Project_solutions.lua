-- Day14 INI JSON Project 參考解答
-- 說明：小專案：INI/JSON（擇一）讀寫合併（簡化版）

-- 1. 簡易 INI parser（無段落、key=value）
local function parse_ini(path)
  local t={{}}; for line in assert(io.open(path,"r")):lines() do
    local k,v = line:match("^%s*([^=]+)%s*=%s*(.-)%s*$"); if k then t[k]=v end
  end; return t
end
local a=parse_ini("a.ini"); local b=parse_ini("b.ini");
for k,v in pairs(b) do a[k]=v end; for k,v in pairs(a) do print(k,v) end

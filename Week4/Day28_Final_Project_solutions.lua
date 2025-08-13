-- Day28 Final Project 參考解答
-- 說明：期末小專案：設定合併 CLI（支援覆蓋與優先）

-- 1. 主程式雛形
local function parse_kv_line(line) local k,v=line:match("^%s*([^=]+)%s*=%s*(.-)%s*$"); if k then return k,v end end
local function load_cfg(path) local t={{}}; local f=assert(io.open(path,"r")); for ln in f:lines() do local k,v=parse_kv_line(ln); if k then t[k]=v end end; f:close(); return t end
local function merge(a,b) for k,v in pairs(b) do a[k]=v end; return a end
local base = load_cfg(arg[1] or "base.ini"); local over = load_cfg(arg[2] or "override.ini"); local r = merge(base, over); for k,v in pairs(r) do print(k.."="..v) end

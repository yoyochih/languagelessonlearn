-- Day28_FinalProject_OpticalRow_Aggregator.lua
-- 說明：掃描資料夾中所有 .row，計算 (RMS, EE@k*RMS) 並輸出排名表 CSV

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local k = tonumber(arg[1]) or 1.0
local out = arg[2] or "aggregate.csv"

local handle = io.popen('ls *.row 2>/dev/null')
local list = {}
for name in handle:lines() do
  local data = row.read_row(name)
  if data then
    local rms = row.rms_radius(data)
    local ee  = row.encircled_energy(data, k*rms)
    list[#list+1] = {name=name, rms=rms, ee=ee}
  end
end
handle:close()
table.sort(list, function(a,b) return a.ee > b.ee end)

local f = assert(io.open(out, "w"))
f:write("name,rms,ee_k\n")
for _,it in ipairs(list) do
  f:write(string.format("%s,%.6f,%.6f\n", it.name, it.rms, it.ee))
end
f:close()
print("OK -> "..out.." (k="..k..")")

-- 練習：
-- 1) 匯出 Top-N（接受參數 N）
-- 2) 依波長欄位（若存在）分群後，各自輸出排名

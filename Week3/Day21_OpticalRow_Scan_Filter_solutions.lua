-- Day21_OpticalRow_Scan_Filter_solutions.lua
package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local handle = io.popen('ls *.row 2>/dev/null')
local k = tonumber(arg[1]) or 1.0
local thresh = tonumber(arg[2]) or 0.8

local list = {}
for name in handle:lines() do
  local data = row.read_row(name)
  if data then
    local rms = row.rms_radius(data)
    local ee = row.encircled_energy(data, k*rms)
    list[#list+1] = {name=name, rms=rms, ee=ee}
  end
end
handle:close()

table.sort(list, function(a,b) return a.ee > b.ee end)

local f = io.open("results.csv", "w")
f:write("name,rms,ee\n")
for _,it in ipairs(list) do
  if it.ee >= thresh then
    f:write(string.format("%s,%.6f,%.6f\n", it.name, it.rms, it.ee))
  end
end
f:close()
print("寫出 results.csv")

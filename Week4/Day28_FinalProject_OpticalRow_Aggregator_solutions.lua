-- Day28_FinalProject_OpticalRow_Aggregator_solutions.lua
package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local k = tonumber(arg[1]) or 1.0
local out = arg[2] or "aggregate.csv"
local N = tonumber(arg[3] or "0") or 0 -- 0 表示不截斷

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
local limit = (N>0 and math.min(N, #list)) or #list

local f = assert(io.open(out, "w"))
f:write("name,rms,ee_k\n")
for i=1,limit do
  local it = list[i]
  f:write(string.format("%s,%.6f,%.6f\n", it.name, it.rms, it.ee))
end
f:close()
print("OK -> "..out.." (k="..k..", N="..tostring(N)..")")

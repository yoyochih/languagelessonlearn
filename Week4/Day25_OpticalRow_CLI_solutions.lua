-- Day25_OpticalRow_CLI_solutions.lua
package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local args = {}
for _,a in ipairs(arg) do local k,v = a:match("^%-%-(%w+)%=(.+)$"); if k then args[k]=v end end
assert(args.path, "need --path=FILE")

local function parse_klist(s)
  local out = {}
  for tok in tostring(s or "1"):gmatch("[^,]+") do out[#out+1] = tonumber(tok) or 1.0 end
  return out
end

local data = assert(row.read_row(args.path))
local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)

local ks = parse_klist(args.klist)
local out = args.out or "summary.csv"
local f = assert(io.open(out, "w"))
f:write("path,cx,cy,rms,k,ee\n")
for _,k in ipairs(ks) do
  local ee  = row.encircled_energy(data, k*rms)
  f:write(string.format("%s,%.6f,%.6f,%.6f,%.3f,%.6f\n", args.path, cx, cy, rms, k, ee))
end
f:close()
print("OK -> "..out)

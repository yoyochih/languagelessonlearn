-- Day25_OpticalRow_CLI.lua
-- 說明：簡易 CLI：lua Day25_OpticalRow_CLI.lua --path=./samples/spot_sample.row --k=1.0 --out=summary.csv

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local function usage()
  print("usage: lua Day25_OpticalRow_CLI.lua --path=FILE --k=FLOAT --out=FILE")
end

local args = {}
for _,a in ipairs(arg) do local k,v = a:match("^%-%-(%w+)%=(.+)$"); if k then args[k]=v end end
if not args.path then usage() os.exit(1) end

local k = tonumber(args.k or "1.0") or 1.0
local data = assert(row.read_row(args.path))
local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
local ee  = row.encircled_energy(data, k*rms)

local out = args.out or "summary.csv"
local f = assert(io.open(out, "w"))
f:write("path,cx,cy,rms,ee_k\n")
f:write(string.format("%s,%.6f,%.6f,%.6f,%.6f\n", args.path, cx, cy, rms, ee))
f:close()
print("OK -> "..out)

-- 練習：加入 --klist=0.5,1,2 支援，輸出多列

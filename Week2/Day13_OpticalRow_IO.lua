-- Day13_OpticalRow_IO.lua
-- 說明：讀寫 .row 與輸出統計摘要（JSON/CSV 二擇一）

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local path = arg[1] or "./samples/spot_sample.row"
local out  = arg[2] or "summary.csv"
local data = assert(row.read_row(path))

local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
local ee50 = row.encircled_energy(data, 1.0 * rms)

-- 範例：輸出 CSV
local f = assert(io.open(out, "w"))
f:write("path,cx,cy,rms,ee@1*rms\n")
f:write(string.format("%s,%.6f,%.6f,%.6f,%.6f\n", path, cx, cy, rms, ee50))
f:close()
print("寫出", out)

-- 練習：
-- 1) 加入 EE@0.5*RMS, EE@2*RMS 欄位
-- 2) 改寫為 JSON（自行格式化字串）

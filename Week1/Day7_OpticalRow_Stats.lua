-- Day7_OpticalRow_Stats.lua
-- 說明：讀取 .row 光學點列資料，計算 centroid、RMS spot、簡易 EE(Encircled Energy)

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local path = arg[1] or "./samples/spot_sample.row"
local data, err = row.read_row(path)
if not data then
  io.stderr:write("讀取失敗: ", err or "unknown", "\n")
  os.exit(1)
end

local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)

print(string.format("Centroid: (%.6f, %.6f)", cx, cy))
print(string.format("RMS radius: %.6f", rms))

-- 計算半徑 r = k * RMS 的 EE
local k = tonumber(arg[2]) or 1.0
local ee = row.encircled_energy(data, k * rms)
print(string.format("EE at r=%.2f*RMS: %.4f", k, ee))

-- 練習：
-- 1) 嘗試不同 k（0.5, 1, 2）觀察 EE 變化
-- 2) 將結果輸出為 CSV：k,EE

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local path = arg[1] or "./samples/spot_sample.row"
local data = assert(row.read_row(path))

local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
print(string.format("Centroid: (%.6f, %.6f)", cx, cy))
print(string.format("RMS radius: %.6f", rms))

-- 1) 嘗試不同 k（0.5, 1, 2）觀察 EE 變化
local ks = {0.5, 1.0, 2.0}
local f = io.open("ee_results.csv", "w")
-- 2) 將結果輸出為 CSV：k,EE
f:write("k,EE\n")
for _,k in ipairs(ks) do
  local ee = row.encircled_energy(data, k * rms)
  f:write(string.format("%.2f,%.6f\n", k, ee))
end
f:close()
print("寫出 ee_results.csv")

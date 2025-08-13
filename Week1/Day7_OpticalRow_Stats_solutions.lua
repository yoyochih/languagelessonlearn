-- Day7_OpticalRow_Stats_solutions.lua
package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local path = arg[1] or "./samples/spot_sample.row"
local data = assert(row.read_row(path))

local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
print(string.format("Centroid: (%.6f, %.6f)", cx, cy))
print(string.format("RMS radius: %.6f", rms))

local ks = {0.5, 1.0, 2.0}
local f = io.open("ee_results.csv", "w")
f:write("k,EE\n")
for _,k in ipairs(ks) do
  local ee = row.encircled_energy(data, k * rms)
  f:write(string.format("%.2f,%.6f\n", k, ee))
end
f:close()
print("寫出 ee_results.csv")

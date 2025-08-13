-- Day13_OpticalRow_IO_solutions.lua
package.path = package.path .. ";./?.lua"
local row = require("utils_row")
local path = arg[1] or "./samples/spot_sample.row"
local out  = arg[2] or "summary.csv"
local data = assert(row.read_row(path))
local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
local f = assert(io.open(out, "w"))
f:write("path,cx,cy,rms,EE0.5,EE1.0,EE2.0\n")
local e05 = row.encircled_energy(data, 0.5*rms)
local e10 = row.encircled_energy(data, 1.0*rms)
local e20 = row.encircled_energy(data, 2.0*rms)
f:write(string.format("%s,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n", path, cx, cy, rms, e05, e10, e20))
f:close()
print("寫出", out)

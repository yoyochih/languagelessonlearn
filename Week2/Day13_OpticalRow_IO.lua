-- Day13_OpticalRow_IO.lua
-- 說明：讀寫 .row 與輸出統計摘要（支援 CSV 和 JSON 格式）

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

local path = arg[1] or "./samples/spot_sample.row"
local out_format = arg[2] or "csv"  -- 可選: csv 或 json
local out_file = arg[3] or "summary." .. out_format

local data = assert(row.read_row(path))

local cx, cy = row.centroid(data)
local rms = row.rms_radius(data)
local ee50 = row.encircled_energy(data, 1.0 * rms)

-- 練習 1: 加入 EE@0.5*RMS, EE@2*RMS 欄位
local ee25 = row.encircled_energy(data, 0.5 * rms)
local ee100 = row.encircled_energy(data, 2.0 * rms)

-- 練習 2: 改寫為 JSON（自行格式化字串）
if out_format:lower() == "json" then
    -- 輸出 JSON 格式
    local f = assert(io.open(out_file, "w"))
    f:write('{\n')
    f:write(string.format('  "file_path": "%s",\n', path))
    f:write(string.format('  "centroid_x": %.6f,\n', cx))
    f:write(string.format('  "centroid_y": %.6f,\n', cy))
    f:write(string.format('  "rms_radius": %.6f,\n', rms))
    f:write(string.format('  "ee_0.5_rms": %.6f,\n', ee25))
    f:write(string.format('  "ee_1.0_rms": %.6f,\n', ee50))
    f:write(string.format('  "ee_2.0_rms": %.6f\n', ee100))
    f:write('}')
    f:close()
    
    print("寫出 JSON 格式: " .. out_file)
else
    -- 輸出 CSV 格式 (預設)
    local f = assert(io.open(out_file, "w"))
    f:write("path,cx,cy,rms,ee@0.5*rms,ee@1*rms,ee@2*rms\n")
    f:write(string.format("%s,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f\n", 
                         path, cx, cy, rms, ee25, ee50, ee100))
    f:close()
    
    print("寫出 CSV 格式: " .. out_file)
end

-- 顯示統計摘要
print("\n統計摘要:")
print(string.format("文件路徑: %s", path))
print(string.format("質心座標: (%.6f, %.6f)", cx, cy))
print(string.format("RMS 半徑: %.6f", rms))
print(string.format("EE@0.5*RMS: %.6f", ee25))
print(string.format("EE@1.0*RMS: %.6f", ee50))
print(string.format("EE@2.0*RMS: %.6f", ee100))
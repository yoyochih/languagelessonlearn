-- Day21_OpticalRow_Scan_Filter.lua
-- 說明：掃描當前資料夾下所有 .row 檔，計算 RMS 與 EE，依門檻過濾並列印

package.path = package.path .. ";./?.lua"
local row = require("utils_row")

-- 使用系統 ls/find；跨平台簡化處理：macOS/Linux 用 ls，Windows 可改用 dir /b
local handle = io.popen('ls *.row 2>/dev/null')
if not handle then
  io.stderr:write("列舉檔案失敗\n")
  os.exit(1)
end

local k = tonumber(arg[1]) or 1.0
local thresh = tonumber(arg[2]) or 0.8  -- EE 門檻（例如 >=0.8）

print(string.format("Filter: EE@%.1f*RMS >= %.2f", k, thresh))

for name in handle:lines() do
  local data = row.read_row(name)
  if data then
    local rms = row.rms_radius(data)
    local ee = row.encircled_energy(data, k*rms)
    if ee >= thresh then
      print(string.format("%-20s  RMS=%8.6f  EE=%.4f", name, rms, ee))
    end
  end
end
handle:close()

-- 練習：
-- 1) 將結果輸出成 results.csv
-- 2) 依照 EE 降序排序後再輸出（提示：先存陣列，寫簡單排序）

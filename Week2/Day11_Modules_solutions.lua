-- Day11 Modules 參考解答
-- 說明：模組與 require、專案結構

-- 1. 建立模組並匯入
-- mathx.lua
local M={{}}; function M.square(x) return x*x end; return M

-- 2. 主程式使用模組
local mathx = require("mathx"); print(mathx.square(9))

-- 3. 封裝與 local
-- 在模組中以 local 隱藏內部細節
local M={{}}; local secret=7; function M.get() return secret end; return M

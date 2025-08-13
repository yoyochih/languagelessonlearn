-- Day12 Error Handling 參考解答
-- 說明：pcall/xpcall、錯誤流程

-- 1. pcall 包裝可能失敗的函式
local function risky(x) if x<0 then error("x<0") end; return math.sqrt(x) end;
local ok,res = pcall(risky, -1); print("ok?", ok, "res", res)

-- 2. xpcall 與 traceback
local function handler(err) print("caught:", err) print(debug.traceback()) end
local function boom() error("boom!") end
xpcall(boom, handler)

-- 3. 安全 IO 包裝
local function safe_open(p) local ok,fh = pcall(io.open,p,"r"); if not ok then return nil,fh end; return fh end; local fh,err=safe_open("nope"); print(fh,err)

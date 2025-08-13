-- Day15 Metatable Basics 參考解答
-- 說明：metatable 與常見 metamethod (__index/__newindex)

-- 1. __index 查表回退
local proto={{x=1}}; local t=setmetatable({{}}, {{__index=proto}}); print(t.x)

-- 2. __newindex 攔截寫入
local t=setmetatable({{}}, {{__newindex=function(tbl,k,v) rawset(tbl,k,v*10) end}}); t.a=2; print(t.a)

-- 3. __tostring
local T={{}}; T.__index=T; function T.new(x) return setmetatable({{x=x}}, T) end; function T:__tostring() return "T("..self.x..")" end; print(T.new(5))

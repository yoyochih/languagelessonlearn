-- Day21 File Scanner Coroutine 參考解答
-- 說明：專案：協程版檔案爬梳器（逐行 + 過濾）

-- 1. 掃描 .md 檔案並找出包含 TODO 的行
local dir="."; local pattern="TODO";
local function scan(path)
  local wrap=coroutine.wrap(function()
    for line in assert(io.open(path,"r")):lines() do if line:find(pattern) then coroutine.yield(path, line) end end
  end); return wrap
end
for name in io.popen("ls *.md 2>/dev/null"):lines() do
  local next=scan(name); local p,l = next(); while p do print(p, l); p,l = next() end
end

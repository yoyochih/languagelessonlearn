-- Day7 Text Statistics Project 參考解答
-- 說明：小專案：文字統計器（行數、詞頻、最長行）

-- 1. 讀取檔案、計數
local file=arg[1] or "README.md"; local fh=assert(io.open(file,"r"));
local lines, maxlen, freq = 0, 0, {}
for line in fh:lines() do
  lines = lines + 1
  if #line > maxlen then maxlen = #line end
  for w in line:lower():gmatch("%w+") do freq[w]=(freq[w] or 0)+1 end
end
fh:close()
print("lines", lines, "maxlen", maxlen)
for k,v in pairs(freq) do if v>5 then print(k,v) end end

-- Day23 Embedding Lua 參考解答
-- 說明：嵌入情境腦補：在工具/遊戲/Neovim 的腳本思路

-- 1. 回呼風格 API 範例（模擬）
local function use(callback) callback("event:start"); callback("event:end") end; use(function(ev) print("handled:", ev) end)

-- 2. 配置表驅動
local config={{retries=3, delay_ms=100}}; print("retries", config.retries, "delay", config.delay_ms)

-- 3. Neovim 思路（純文字示例）
print("在 Neovim 中使用 Lua 設定快捷鍵與自動命令（此處僅示例，不直接操作編輯器）")

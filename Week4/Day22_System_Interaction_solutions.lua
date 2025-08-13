-- Day22 System Interaction 參考解答
-- 說明：命令列參數、環境變數

-- 1. 讀取命令列參數
print("arg[0]=", arg[0] or ""); for i=1,#arg do print(i, arg[i]) end

-- 2. 讀取環境變數
print(os.getenv("HOME"))

-- 3. 退出碼
os.exit(0)

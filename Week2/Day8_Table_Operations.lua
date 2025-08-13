-- Day8 Table Operations
-- 說明：插入、刪除、排序、淺拷貝

-- 範例：
print("Hello from Day8_Table_Operations")

-- 練習：
-- 1. 排序數列
-- local t={{5,1,4,2}}; table.sort(t); for i=1,#t do print(t[i]) end
local t = {5,1,4,2} table.sort(t) print("排序結果:") for i=1,#t do print(t[i]) end  -- 輸出：1 2 4 5

-- 2. 淺拷貝
-- local function clone(a) local b={{}}; for k,v in pairs(a) do b[k]=v end; return b end; local x={{a=1}}; local y=clone(x); print(y.a)
-- 正确的浅拷贝实现
local function shallowCopy(original)
    local copy = {}  -- 创建新表格
    for k, v in pairs(original) do
        copy[k] = v  -- 仅复制第一层键值对
    end
    return copy
end

-- 测试用例
local original = {
    number = 1,
    nested = {2, 3},  -- 嵌套表格会被共享
    func = function() return "hello" end
}

local copied = shallowCopy(original)

print("原始表格:", original.nested[1])  -- 输出: 2
print("拷贝表格:", copied.nested[1])    -- 输出: 2

-- 修改嵌套表格测试
copied.nested[1] = 99
print("\n修改后原始表格:", original.nested[1])  -- 输出: 99（证明是浅拷贝）
print("修改后拷贝表格:", copied.nested[1])     -- 输出: 99

-- 3. 移除元素
-- local t={{"x","y","z"}}; table.remove(t,2); for i=1,#t do print(t[i]) end
local letters = {"x", "y", "z"} table.remove(letters, 2) print("\n单层表格移除结果:") for i,v in ipairs(letters) do print(i,v) end  -- 输出：1 x, 2 z


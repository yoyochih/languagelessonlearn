-- Day16 OOP Style 參考解答
-- 說明：用 metatable 模擬類別/方法調用

-- 1. 類別風格與 : 語法
local Vec={{}}; Vec.__index=Vec; function Vec.new(x,y) return setmetatable({{x=x,y=y}}, Vec) end; function Vec:len() return math.sqrt(self.x*self.x+self.y*self.y) end; local v=Vec.new(3,4); print(v:len())

-- 2. 運算子重載 __add
local V={{}}; V.__index=V; function V.new(x,y) return setmetatable({{x=x,y=y}}, V) end; function V.__add(a,b) return V.new(a.x+b.x, a.y+b.y) end; local a,b=V.new(1,2),V.new(3,4); local c=a+b; print(c.x,c.y)

-- 3. 封裝私有成員（約定）
local C={{}}; C.__index=C; local function make(secret) return setmetatable({{_secret=secret}}, C) end; function C:get() return self._secret end; local o=make(42); print(o:get())

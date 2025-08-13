-- utils_row.lua
-- 通用 .row 檔解析工具（支援逗號或空白分隔；忽略以 # 或 ; 開頭的註解行）
local M = {}

local function is_number(s)
  return tonumber(s) ~= nil
end

local function split_fields(line)
  local fields = {}
  if line:find(",") then
    for token in line:gmatch("[^,]+") do fields[#fields+1] = token end
  else
    for token in line:gmatch("%S+") do fields[#fields+1] = token end
  end
  return fields
end

local function trim(s) return (s:gsub("^%s+",""):gsub("%s+$","")) end

-- 解析 .row：回傳陣列，每列為 {x=..., y=..., i=..., wl=...}
-- 若首行為表頭，支援欄名：x,y,i/irr/intensity, wl/wavelength
-- 否則假設欄位順序為：x y i [wl]
function M.read_row(path)
  local out = {}
  local fh, err = io.open(path, "r")
  if not fh then return nil, err end

  local header = nil
  -- 找到第一個非註解行，檢查是否為表頭
  local lines = {}
  for line in fh:lines() do
    if not line:match("^%s*[#;]") and trim(line) ~= "" then
      if not header and not is_number(line:match("%S+")) then
        header = split_fields(line)
      else
        lines[#lines+1] = line
      end
    end
  end
  fh:close()

  local idx = {x=1, y=2, i=3, wl=4}
  if header then
    local map = {}
    for k,v in ipairs(header) do map[trim(v):lower()] = k end
    idx.x  = map["x"] or 1
    idx.y  = map["y"] or 2
    idx.i  = map["i"] or map["irr"] or map["intensity"] or 3
    idx.wl = map["wl"] or map["wavelength"] or map["lambda"] or 4
  end

  for _,line in ipairs(lines) do
    local f = split_fields(line)
    local row = {}
    row.x  = tonumber(f[idx.x]) or 0.0
    row.y  = tonumber(f[idx.y]) or 0.0
    row.i  = tonumber(f[idx.i]) or 1.0
    row.wl = tonumber(f[idx.wl]) or nil
    out[#out+1] = row
  end
  return out
end

-- 幾何 centroid
function M.centroid(rows)
  local sx, sy, si = 0, 0, 0
  for _,r in ipairs(rows) do
    sx = sx + r.x * r.i
    sy = sy + r.y * r.i
    si = si + r.i
  end
  if si == 0 then return 0,0 end
  return sx/si, sy/si
end

-- RMS spot size（相對 centroid）
function M.rms_radius(rows)
  local cx, cy = M.centroid(rows)
  local s, si = 0, 0
  for _,r in ipairs(rows) do
    local dx, dy = r.x - cx, r.y - cy
    s  = s + (dx*dx + dy*dy) * r.i
    si = si + r.i
  end
  if si == 0 then return 0 end
  return math.sqrt(s/si)
end

-- Encircled Energy（半徑 r 內占比）
function M.encircled_energy(rows, radius)
  local cx, cy = M.centroid(rows)
  local inside, total = 0, 0
  for _,r in ipairs(rows) do
    local dx, dy = r.x - cx, r.y - cy
    local rr = dx*dx + dy*dy
    total = total + r.i
    if rr <= radius*radius then inside = inside + r.i end
  end
  if total == 0 then return 0 end
  return inside / total
end

return M

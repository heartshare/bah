local _M = {}

function _M.shorten(long_url)
  math.randomseed(os.time() + math.random(0, 100000))
  local s = ""
  local cz= {"a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "v", 
             "m", "n", "o", "p", "q", "r", "s", "t", "w", "x", "y", "z" }
  for _ = 1, 6, 1 do
    local index = math.random(1, #cz) 
    s = s .. cz[index] 
    end
  return s
end

function _M.pg_escape(str)
  return ngx.quote_sql_str(str)
end

return _M

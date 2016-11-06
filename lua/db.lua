local config = require 'config'
local util   = require 'util'
local pg     = require 'resty.postgres'
local _M     = {}

function _M.query(self, sql)
  local db  = pg:new()
  db:set_timeout(3000)
  local con, err = db:connect(config.db)
  if con then 
    return db:query(sql)
  else
    return ngx.say(err) 
  end
end

function _M.save(self, long_url, short_url)
  local qs  = "INSERT INTO url(long_url, short_url, ts, visited) VALUES(%s, %s, NOW(), 0)"
  local sql = string.format(qs, util.pg_escape(long_url), util.pg_escape(short_url)) 
  return self:query(sql)
end

function _M.find_long_one(self, long_url)
  local qs  = "SELECT * FROM url WHERE long_url=%s"
  local sql = string.format(qs, util.pg_escape(long_url))
  return self:query(sql)
end

function _M.find_short_one(self, short_url)
  local qs  = "SELECT * FROM url WHERE short_url=%s"
  local sql = string.format(qs, util.pg_escape(short_url))
  return self:query(sql)
end

function _M.increase_view_count(self, short_url)
  local qs  = "UPDATE url SET view=view+1 WHERE short_url=%s" 
  local sql = string.format(qs, util.pg_escape(short_url))
  return self:query(sql)
end

return _M

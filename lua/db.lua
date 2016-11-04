local config = require 'config'
local util   = require 'util'
local pg     = require 'resty.postgres'
local _M     = {}
local db     = pg:new()

db:set_timeout(3000)

function _M.connect(self)
  local ok, err = db:connect(config.db)
  if not ok then ngx.say(err) end
end

function _M.save(self, long_url, short_url)
  self:connect()
  local qs  = "INSERT INTO url(long_url, short_url, ts, visited) VALUES(%s, %s, NOW(), 0)"
  local sql = string.format(qs, util.pg_escape(long_url), util.pg_escape(short_url)) 
  local ok, err = db:query(sql)
  db:set_keepalive(0, 100)
  return ok, err 
end

function _M.find_long_one(self, long_url)
  self:connect()  
  local qs  = "SELECT * FROM url WHERE long_url=%s"
  local sql = string.format(qs, util.pg_escape(long_url))
  local ok, err = db:query(sql)
  db:set_keepalive(0, 100)
  return ok, err
end

function _M.find_short_one(self, short_url)
  self:connect()  
  local qs  = "SELECT * FROM url WHERE short_url=%s"
  local sql = string.format(qs, util.pg_escape(short_url))
  local ok, err = db:query(sql)
  db:set_keepalive(0, 100)
  return ok, err
end

function _M.increase_view_count(self, short_url)
  self:connect()  
  local qs  = "UPDATE url SET view=view+1 WHERE short_url=%s" 
  local sql = string.format(qs, util.pg_escape(short_url))
  local ok, err = db:query(sql)
end

return _M

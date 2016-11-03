local config = require 'config'
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
  local qs  = "INSERT INTO bah(long_url, short_url, ts) VALUES('%s', '%s', NOW())"
  local sql = string.format(qs, long_url, short_url) 
  local ok, err = db:query(sql)
  db:set_keepalive(0, 100)
  return ok, err 
end

function _M.get(self, short_url)
  self:connect()  
  local qs  = "SELECT * FROM bah WHERE short_url='%s'"
  local sql = string.format(qs, short_url)
  local ok, err = db:query(sql)
  db:set_keepalive(0, 100)
  return ok, err
end

-- TODO: update url view stats

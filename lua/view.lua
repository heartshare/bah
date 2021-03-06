local config = require 'config'
local db     = require 'db'

local short_url = string.gsub(ngx.var.request_uri, '/', '')
local res, err  = db:find_short_one(short_url)

if res and #res > 0 then
  local data = res[1]
  db:increase_view_count(short_url)
  ngx.redirect(data.long_url)
else
  ngx.say('URL do not exists')
end

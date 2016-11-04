local config = require 'config'
local util   = require 'util'
local db     = require 'db'

local args = ngx.req.get_uri_args()
local long_url = args['url']

if not long_url then 
  return ngx.say('Missing Url') 
end 

local res, err = db:find_long_one(long_url)

if res and  #res > 0 then
  local data = res[1]
  ngx.say(config.url .. '/' .. data.short_url) 
else
  local short_url = util.shorten(long_url) 
  local ok, err   = db:save(long_url, short_url)
  if ok then 
    ngx.say(config.url .. '/' .. short_url) 
  else 
    ngx.log(ngx.ERR, 'Failed to save url to db ' .. err)
    ngx.say(err) 
  end
end

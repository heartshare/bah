local config = require 'config'
local util   = require 'util'
local db     = require 'db'

local args = ngx.req.get_uri_args()
local long_url = args['url']

if not long_url or util.valid_url(long_url) == false then 
  return ngx.say('Missing or invalid url') 
end 

local res, err = db:find_long_one(long_url)

-- we have record of the long url
if res and  #res > 0 then
  return ngx.say(config.url .. '/' .. res[1].short_url) 
end

-- create new entry
local short_url = util.shorten(long_url) 
local ok, err   = db:save(long_url, short_url)
if ok then 
  ngx.say(config.url .. '/' .. short_url) 
else 
  ngx.log(ngx.ERR, 'Failed to save url to db ' .. err)
  ngx.say(err) 
end

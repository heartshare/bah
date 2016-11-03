local config = require 'config'
local db     = require 'db'

-- generate random string
local shorten = function(long_url)
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

local args = ngx.req.get_uri_args()
local long_url = args['url']

-- TODO: verify url format
if not long_url then return ngx.say('Missing Url') end

local short_url = shorten(long_url) 

-- save url into datababase
local ok, err = db:save(long_url, short_url)

--TODO: avoid sql injection attack

if res then ngx.say(config.url .. '/' .. short_url) end

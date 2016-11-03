local config = require 'config'
local pg     = require 'resty.postgres'

-- generate random string
local shorten = function(long_url)
  local s = ""
  local cz= {"a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "v", 
             "m", "n", "o", "p", "q", "r", "s", "t", "w", "x", "y", "z" }
  math.randomseed(os.time() + math.random(0, 100000))
  for _ = 1, 6, 1 do
    local index = math.random(1, #cz) 
    s = s .. cz[index] 
    end
  return s
end

local args = ngx.req.get_uri_args()
local long_url = args['url']
if not long_url then return ngx.say('Missing Url') end

local short_url = shorten(long_url) 

-- save url into datababase
local db = pg:new()
db:set_timeout(3000)

local ok, err = db:connect(config.db)

ngx.say('https://bah.my/' .. short_url)

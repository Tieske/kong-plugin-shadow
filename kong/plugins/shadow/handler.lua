---
--- Created by liuxiaodong
--- Modified by lgazo (v1), nhp0712 (v2)
--- DateTime: 2019/4/3 19:10
---
local http = require("resty.http")



local plugin = {
  PRIORITY = 1,
  VERSION = "0.1.0",
}



local function execute(url, path, method, headers, query, body)
  local httpc = http.new()
  local _, host, port = unpack(httpc:parse_uri(url))

  httpc:set_timeouts(5, 100, 100) -- connect_timeout, send_timeout, read_timeout
  httpc:connect(host, port)

  -- res:status,reason,headers,has_body,body_reader,read_body,read_trailers
  local res, err = httpc:request({
    path = path,
    method = method,
    query = query,
    body = body,
    headers = headers
  })

  if not res then
    kong.log.err("request:", url, " call failed. err=", err)
    return nil
  end

  httpc:set_keepalive(60000,20000) -- max_idle_timeout(ms), pool_size(each worker)
end



local function serialize(conf)
  local request = {
    method = ngx.req.get_method(),
    headers = ngx.req.get_headers(),
    query = ngx.req.get_uri_args(),
    path = ngx.var.uri,
    body = conf.shadow_request_body and ngx.req.get_body_data() or nil
  }

  return request
end



local function shadow(premature, conf, request)
  for _, endpoint in pairs(conf.shadow_endpoints) do
    execute(endpoint, request.path, request.method, request.headers, request.query, request.body)
  end
end



function plugin:access(conf)
  if conf.shadow_request_body then
    ngx.req.read_body()
  end
end



function plugin:log(conf)
  if math.random(1,100) >= conf.weight then
    return
  end

  local request = serialize(conf)
  local ok, err = ngx.timer.at(0, shadow, conf, request)
  if not ok then
    kong.log.err("failed to create timer: ", err)
  end
end



return plugin

---
--- Created by liuxiaodong
--- Modified by lgazo (v1), nhp0712 (v2)
--- DateTime: 2019/4/3 19:10
---
local typedefs = require "kong.db.schema.typedefs"

return {
  name = "shadow",
  fields = {
    { protocols = typedefs.protocols_http },
    {
      config = {
        type = "record",
        fields = {
          { weight = {
              type = "number",
              between = { 0, 100 },
              default = 100,
              required = true,
          }, },
          { shadow_request_body = {
              type = "boolean",
              default = false,
              required = true,
          }, },
          { shadow_endpoints = {
              type = "array",
              required = true,
              elements = {
                type = "string",
              },
          }, },
        },
      },
    },
  },
}

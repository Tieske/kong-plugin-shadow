# Kong Shadow Plugin


> A Kong plugin that will shadow original request to other endpoints.

## Description


This is a plugin like nginx ```mirror``` directive. It can mirror origin request to one or more endpoint.

## Configuration


```json
{
    "name": "shadow",
    "config": {
        "weight": 100,
        "shadow_request_body": "false",
        "shadow_endpoints": [
            "http://127.0.0.1:9001"
        ]
    }
}
```

| parameter                  | type   | default | description |
| ----------                 | ----   |  ------ | ------------|
| name                       | string |         | shadow |
| config.weight              | number | 100     | percentage of requests that is shadowed |
| config.shadow_request_body | string | false   | Indicates whether the client request body is shadowed. |
| config.shadow_endpoints    | array  |         | endpoint |


## Installation

This is easiest using LuaRocks.

## Author

tarepanda1024
lgazo
nhp0712

## Liscence


MIT License

Copyright (c) 2019

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

{
  "$schema": "https://vega.github.io/schema/vega/v5.json",
  "description": "line chart",
  "width":800,
  "height":400,
  "padding":5,
  "autosize":"fit",

  "signals": [
    {
      "name":"interpolate",
      "description": "change the interpolate type",
      "bind": {
        "input":"radio",
        "options":[
          "basis","bundle","cardinal","catnull-rom",
          "linear","step","step-after","step-before"
          ]
      }
    },
    {
      "name":"show_text",
      "value":{},
      "on": [
        {"events":"line:mouseover","update":"datum"},
        {"events":"line:mouseout","update":"{}"}
      ]
    }
  ],

  "data": [
    {
      "name":"mydt",
      "values":[
        {"x": 0, "y": 28, "c":0}, {"x": 0, "y": 20, "c":1},
        {"x": 1, "y": 43, "c":0}, {"x": 1, "y": 35, "c":1},
        {"x": 2, "y": 81, "c":0}, {"x": 2, "y": 10, "c":1},
        {"x": 3, "y": 19, "c":0}, {"x": 3, "y": 15, "c":1},
        {"x": 4, "y": 52, "c":0}, {"x": 4, "y": 48, "c":1},
        {"x": 5, "y": 24, "c":0}, {"x": 5, "y": 28, "c":1},
        {"x": 6, "y": 87, "c":0}, {"x": 6, "y": 66, "c":1},
        {"x": 7, "y": 17, "c":0}, {"x": 7, "y": 27, "c":1},
        {"x": 8, "y": 68, "c":0}, {"x": 8, "y": 16, "c":1},
        {"x": 9, "y": 49, "c":0}, {"x": 9, "y": 25, "c":1}
      ]
    }
  ],

  "scales": [
    {
      "name":"xx",
      "type":"point",
      "domain":{"data":"mydt","field":"x"},
      "range":"width"
    },
    {
      "name": "yy",
      "type":"linear",
      "domain":{"data":"mydt","field":"y"
      },
      "range":"height",
      "nice":true,
      "zero":true
    },
    {
      "name":"cc",
      "type":"ordinal",
      "domain":{"data":"mydt","field":"c"},
      "range":"category"
    }
  ],


  "axes": [
    {
      "scale": "xx",
      "orient":"bottom",
      "domain": true,
      "domainColor":"black",
      "domainWidth":2,
      "domainOpacity":1,
      "grid": true,
      "gridColor":"orange",
      "gridDash":[3],
      "gridOpacity":0.4,
      "gridScale": "yy",
      "gridWidth":2,
      "labelFontSize":15,
      "title":"x",
      "titleFontSize":20,
      "tickWidth":3,
      "tickSize":6
    },
    {
      "scale": "yy",
      "orient":"left",
      "domain": true,
      "domainColor":"black",
      "domainWidth":2,
      "domainOpacity":1,
      "grid": true,
      "gridColor":"steelblue",
      "gridDash":[3],
      "gridOpacity":0.4,
      "gridScale": "xx",
      "gridWidth":2,
      "labelFontSize":15,
      "title":"Y",
      "titleFontSize":20,
      "titlePadding":15,
      "titleAngle":0
    }
  ],

  "marks":[
    {
      "type": "group",
      "from":{
        "facet":{"name":"my_facet","data": "mydt","groupby": "c"}
      },
      "marks": [
        {
          "type":"line",
          "from":{"data":"my_facet"},
          "encode":{
            "enter":{
              "x":{"scale":"xx","field":"x"},
              "y":{"scale":"yy","field":"y"},
              "stroke":{"scale":"cc","field":"c"},
              "strokeOpacity":{"value":0.7},
              "strokeWidth":{"value":5}
            },
            "update":{
              "interpolate":{"signal":"interpolate"},
              "strokeOpacity":{"value":0.7},
              "strokeWidth":{"value":4}
            },
            "hover":{
              "strokeOpacity":{"value":0.9},
              "strokeWidth":{"value":8}
            },
            "exit":{}
          }
        }
      ]
    },
    {
      "type": "text",
      "from":{"data": "mydt"},
      "encode": {
        "enter":{
          "x":{"scale":"xx","field":"x"},
          "y":{"scale":"yy","field":"y"},
          "text":{"field":"y"},
          "dx":{"value":-10},
          "dy":{"value":-10},
          "fill":{"value":"black"},
          "fontSize":{"value": 20}
        },
        "update":{
          "fillOpacity":[
            {"test": "datum.c === show_text.c", "value": 1},
            {"value":0}
          ]
        }
      }
    }
  ]
}

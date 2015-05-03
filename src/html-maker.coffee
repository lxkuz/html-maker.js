helper = require "src/helper"
class HtmlMaker
  start: (func) =>
    @buffer = []
    helper.makeTagFunctions @
    res = helper.use func, @, @
    @toString(res)

  tag: (tagName, attrs, func) ->
    obj = {}
    obj.buffer = []
    obj.tagName = tagName
    obj.tag = @tag
    obj.attrs = {}
    helper.makeTagFunctions obj

    if !func && typeof attrs is "function"
      func = attrs

    if func
      if typeof func is "function"
        obj.text = helper.use func, obj, obj
      else
        obj.text = func

    if attrs
      if typeof attrs is "object"
        obj.attrs = attrs
      if !func && typeof attrs is "string"
        obj.text = attrs
      if func && typeof attrs is "string"
        obj.attrs = {class: attrs}

    @buffer.push obj
    undefined

  #output
  toString: (end) =>
    res = (@draw(el) for el in @buffer).join("")
    res += end if end && typeof(end) is "string"
    res

  draw: (el) =>
    attrs = for key, val of el.attrs
      ["#{key}='#{val}'"]
    content = []
    for subEl in el.buffer
      content.push @draw(subEl)
    content.push el.text if el.text && typeof(el.text) is "string"
    "<#{el.tagName}#{if attrs.length > 0 then " " + attrs.join(" ") else ""}>#{content.join('')}</#{el.tagName}>"

if typeof module is "object" && typeof module.exports is "object"
  module.exports = (new HtmlMaker).start

try
  window.htmlmake = (new HtmlMaker).start
  window.HtmlMaker = HtmlMaker



helper = require "src/helper"
class HtmlMaker
  start: (func) =>
    @buffer = []
    helper.makeTagFunctions @
    res = helper.use func, @
    @toString(res)

  el: (parent, tag, attrs, func) ->
    obj = {}
    obj.buffer = []
    obj.tag = tag
    obj.el = @el
    obj.attrs = {}
    helper.makeTagFunctions obj

    if !func && typeof attrs is "function"
      func = attrs

    if func
      if typeof func is "function"
        obj.text = helper.use func, obj
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
    res += end if end
    res

  draw: (el) =>
    attrs = for key, val of el.attrs
      ["#{key}='#{val}'"]
    content = []
    for subEl in el.buffer
      content.push @draw(subEl)
    content.push el.text if el.text
    "<#{el.tag}#{if attrs.length > 0 then " " + attrs.join(" ") else ""}>#{content.join('')}</#{el.tag}>"

if typeof module is "object" && typeof module.exports is "object"
  module.exports = (new HtmlMaker).start

try
  window.htmlmake = (new HtmlMaker).start
  window.HtmlMaker = HtmlMaker



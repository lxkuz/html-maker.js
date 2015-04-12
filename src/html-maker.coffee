helper = require "src/helper"

class HtmlMaker
  constructor: ->
    for tag in helper.tags
      helper.definePattern @, tag, ["object", "string"], (attrs, func) ->
        obj = {}
        obj.attrs = attrs
        obj.buffer = []
        obj.tag = tag
        obj.func = func
        @buffer.push obj

      helper.definePattern @, tag, ["object", "string"], (attrs, content) ->
        console.log("pattern MATCH")
        console.log arguments
        obj = {}
        obj.attrs = attrs
        obj.buffer = []
        obj.tag = tag
        obj.text = content
        @buffer.push obj

      helper.definePattern @, tag, ["string"], (content) ->
        obj = {}
        obj.attrs = {}
        obj.buffer = []
        obj.tag = tag
        obj.text = content
        @buffer.push obj

  start: (func) =>
    console.log("start")
    @buffer = []


    console.log("use draw")
    helper.use func, @
    @toString()

  #  el: (parent, tag, attrs, func) ->
  #    @func = func
  #    @attrs = attrs
  #    @buffer = []
  #    @tag = tag
  #    obj = {}
  #    #    for tgname in helper.tags
  #    #      obj.el = @el
  #    #      obj[tgname] = helper.partial(@el, @, tgname)
  #    helper.use @func, obj
  #    parent.buffer.push @

  #output
  toString: =>
    console.log("toString")
    (@draw(el) for el in @buffer).join("")

  draw: (el) =>
    console.log("draw el #{JSON.stringify(el)}")
    attrs = ""
    attrs += "#{key}='#{val}' " for key, val of el.attrs
    console.log(attrs)
    content = []
    unless el.text
      for subEl in el.buffer
        content.push @draw(subEl)
    else
      if typeof el.text is "function"
        content = helper.use(el.text, @)
      else
        content = [el.text]
    "<#{el.tag}#{if attrs then " " + attrs else ""}>#{content.join('')}</#{el.tag}>"

if typeof module is "object" && typeof module.exports is "object"
  module.exports = (new HtmlMaker).start

try
  window.htmlMake = (new HtmlMaker).start
  window.HtmlMaker = HtmlMaker



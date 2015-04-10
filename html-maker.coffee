helper = require "src/helper"

class HtmlMaker

  start: (draw) =>
    @buffer = []
    for tag in helper.tags
      @[tag] = helper.partial @el, @, tag

    @use draw, @
    @

  el: (parent, tag, attrs, func) ->
    @func = func
    @attrs = attrs
    @buffer = []
    @tag = tag

    obj = {}

    for tgname in helper.tags
      obj[tgname] = helper.partial(HtmlMaker.prototype.el, @, tgname)

    helper.use @func, obj

    parent.buffer.push @


  #output
  toString: =>
    (@draw(el) for el in @buffer).join("")

  draw: (el) =>
    attrs = ""
    attrs += "#{key}='#{val}' " for key, val of el.attrs
    content = []
    console.log el
    console.log(el.buffer)
    unless el.text
      for subEl in el.buffer
        content.push @draw(subEl)
    else
      content = [el.text]
    "<#{el.tag} #{attrs}>#{content.join('')}</#{el.tag}>"



if typeof module is "object" && typeof module.exports is "object"
  module.exports = (new HtmlMaker).start
else
  if window
    window.htmlMake = (new HtmlMaker).start
    window.HtmlMaker = HtmlMaker



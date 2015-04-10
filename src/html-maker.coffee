Helper = require "src/helper"

class HtmlMaker
  tags: ["div", "ul", "li", "a", "span"]



  partial: (f, values...) ->
    (args...) -> f.apply @, values.concat(args)

  start: (draw) =>
    return "123qwe"
    @buffer = []

    for tag in HtmlMaker.prototype.tags
      @[tag] = HtmlMaker.prototype.partial @el, @, tag
    @use draw, @
    @

  el: (parent, tag, attrs, func) ->
    @func = func
    @attrs = attrs
    @buffer = []
    @tag = tag

    obj = {}

    for tgname in HtmlMaker.prototype.tags
      obj[tgname] = HtmlMaker.prototype.use(HtmlMaker.prototype.partial(HtmlMaker.prototype.el, @, tgname), obj)

    HtmlMaker.prototype.use @func, obj

    parent.buffer.push @
    console.log "</#{@tag}>"


  #output
  toString: =>
    (@draw(el) for el in @buffer).join("")

  draw: (el) =>
    console.log(el)
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



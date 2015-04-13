Helper =
  partial: (f, values...) ->
    bounded = for element in values
      element
    (args...) ->
      f.apply @, bounded.concat(args)

  use: (fnc, context, args...) ->
    if fnc && typeof fnc is "function"
      fnc.apply(context, args)
    else
      fnc

  makeTagFunctions: (obj) ->
    for tgname in Helper.tags
      obj[tgname] = Helper.partial(obj.el, obj, tgname)


  tags: ["div", "ul", "li", "a", "h1", "h2", "h3", "h4", "span"]

module.exports = Helper
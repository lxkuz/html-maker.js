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

  dropTagFunctions: (obj) ->
    for tag in Helper.tags
      delete obj[tag]

  tags: ["div", "ul", "li", "form", "input", "select", "option", "i", "a", "h1", "h2", "h3", "h4", "span"]

  makeTagFunctions: (obj) ->
    for tag in Helper.tags
      throw "key '#{tag}' already exists" if obj[tag]
      obj[tag] = Helper.partial(obj.el, obj, tag)

  tags: ["div", "ul", "li", "form", "input", "select", "option", "i", "a", "h1", "h2", "h3", "h4", "span"]

module.exports = Helper
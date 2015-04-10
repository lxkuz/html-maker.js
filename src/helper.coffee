Helper =
  partial: (f, values...) ->
    (args...) -> f.apply @, values.concat(args)

  use: (fnc, context, args...) ->
    if fnc && typeof fnc is "function"
      fnc.apply(context, args)
    else
      fnc

  tags: ["div", "ul", "li", "a", "span"]

module.exports = Helper
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
      obj[tgname] = Helper.partial(obj.tag, tgname)

  tags: ["div", "ul", "ol", "li",
         "form", "input", "select", "option", "button", "textarea",
         "p", "table", "td", "tr", "blockquote",
         "noframes", "frame", "iframe",  "pre", "b", "em", "hr",
         "img", "html", "body", "head", "footer", "title",
         "i", "a", "h1", "h2", "h3", "h4", "h5", "h6", "span"]

module.exports = Helper
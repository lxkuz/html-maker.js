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

  tags: ["div", "ul", "li", "a", "span"]

  definePattern: (context, name, patterns, func) ->
    originFunc = context[name]
    flag = "_pm_#{name}_result"
    patternMatchFunc = ->
      return @[flag] if @[flag]
      for pattern, i in patterns
        arg = arguments[i]
        return unless typeof arg is pattern
      @[flag] = func.apply @, arguments

    if originFunc && typeof originFunc is "function"
      context[name] = ->
        @[flag] = undefined
        originFunc.apply @, arguments
        patternMatchFunc.apply @, arguments
    else
      context[name] = ->
        @[flag] = undefined
        patternMatchFunc.apply @, arguments

module.exports = Helper
html = htmlMake ->
  @div id: "a1", ->
    "world"

#    @div id: "a1", class:"hello", ->
#      @a id: "b1", href: "http://google.com", ->
#        @span id:"c1", class: "arrow", -> ""
#        @span id:"c2", class: "hello", -> "Go to Google!"

window.t = html

#console.log html.toString()

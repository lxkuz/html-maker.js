assert = require "assert"
htmlmake = require "src/html-maker"
helper = require "src/helper"

describe 'Begin testing of html-maker', ->
  describe 'infrastructure testing', ->
    it 'partial method testing',  ->
      a = (a, b, c) ->
        "#{a}#{b}#{c}"
      b = helper.partial(a, 1, 2)
      c = helper.partial(a, 9)

      assert.equal b("3"), "123"
      assert.equal c("7", "8"), "978"

      obj ={}
      for name in ["hello", "world"]
        obj[name] = helper.partial(a, name)

      assert.equal obj.hello("3", "1"), "hello31"
      assert.equal obj.world("3", "1"), "world31"


    it '"use" method testing',  ->
      a = {b: 233}
      func = -> @["b"]
      assert.equal helper.use(func, a), 233


  describe 'simple using', ->
    it "should returns nothing with array",  ->
      html = htmlmake ->
        []
      assert.equal html, ""

    it "should returns empty el if array inside ",  ->
      html = htmlmake ->
        @div ->
          []
      assert.equal html, "<div></div>"

    it "should returns nothing with object",  ->
      html = htmlmake ->
        {}
      assert.equal html, ""

    it "should returns empty el if object inside ",  ->
      html = htmlmake ->
        @div ->
          {}
      assert.equal html, "<div></div>"


    it "should return result of main handler", ->
      html = htmlmake ->
        "returns!"

      assert.equal html, "returns!"

      html = htmlmake ->
        @span()
        "returns!"

      assert.equal html, "<span></span>returns!"


    it 'no attributes, only string content ', ->
      html = htmlmake ->
        @div "world"

      assert.equal html, "<div>world</div>"

    it 'setts attributes (class) and handler with content', ->
      html = htmlmake ->
        @div class: "hello",  ->
          "world"

      assert.equal html, "<div class='hello'>world</div>"


    it 'setts attributes (id) and with content', ->
      html = htmlmake ->
        @div id: "hello", "world"

      assert.equal html, "<div id='hello'>world</div>"


    it 'no attributes, only handler with content ', ->
      html = htmlmake ->
        @div ->
          "world"

      assert.equal html, "<div>world</div>"


    it 'another tag type', ->
      html = htmlmake ->
        @span "span world"

      assert.equal html, "<span>span world</span>"

      html = htmlmake ->
        @li "li world"

      assert.equal html, "<li>li world</li>"

  describe 'nested structure', ->
    it 'ul with li', ->
      html = htmlmake ->
        @ul ->
          @li "one"
          @li "two"
          @li "three"


      assert.equal html, "<ul><li>one</li><li>two</li><li>three</li></ul>"

    it 'multiple elements', ->
      html = htmlmake ->
        @span id: "first", "1"
        @span class: "second", "2"
        @a href:"http://google.com", "Hello"

      assert.equal html, "<span id='first'>1</span><span class='second'>2</span><a href='http://google.com'>Hello</a>"



    it "level: hard", ->
      data =
        name: "Alexey",
        age: 25

      html = htmlmake ->
        @div "header", ->
          @span id: "first", "1"
          @span class: "second", "2"
          @a href:"http://google.com", ->
            @h1 "Hello"
        @div class: "body", id: "-body-container", ->
          @ul ->
            @li ->
              "Hello, #{data.name}!"
            @li "one", "Your age is - #{data.age}"
            @li()

      assert.equal html, "<div class='header'>" +
        "<span id='first'>1</span>" +
        "<span class='second'>2</span>" +
        "<a href='http://google.com'><h1>Hello</h1></a>" +
      "</div>" +
      "<div class='body' id='-body-container'>" +
        "<ul>" +
          "<li>Hello, Alexey!</li>" +
          "<li class='one'>Your age is - 25</li>" +
          "<li></li>" +
        "</ul>" +
      "</div>"

  describe "using own context", ->
    it "should works with build variable, simple div", ->
      html = htmlmake (mk)->
        mk.div "hello"
      assert.equal html, "<div>hello</div>"

    it "should works with build variable, nested structure", ->
      html = htmlmake (mk)->
        mk.div class:"hello", (mk)->
          mk.span "world"
      assert.equal html, "<div class='hello'><span>world</span></div>"

    it "final test: custom 'this'", ->
      @hello = "world"
      html = htmlmake (mk)=>
        mk.span @hello
        mk.div class:"hello", (mk)=>
          mk.span @hello
      assert.equal html, "<span>world</span><div class='hello'><span>world</span></div>"


    it "using loop and custom 'this'", ->
      @names = ["katarina", "Diana", "Alistar"]
      html = htmlmake (m)=>
        m.div "names", (m)=>
          m.ul (m)=>
            for name in @names
              m.li name


      assert.equal html, "<div class='names'>" +
          "<ul>" +
            "<li>katarina</li>" +
            "<li>Diana</li>" +
            "<li>Alistar</li>" +
          "</ul>" +
        "</div>"
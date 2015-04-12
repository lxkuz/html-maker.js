assert = require "assert"
htmlMake = require "src/html-maker"
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

    it "pattern matching",  ->
      obj = {}
      helper.definePattern obj, "test", ["string"], ->
        "a string!"

      helper.definePattern obj, "test", ["object", "string"], ->
        "object and string!"

      assert.equal obj.test({}, "123", 123), "object and string!"
      assert.equal obj.test({}, "123"), "object and string!"
      assert.equal obj.test("123", 123, {}), "a string!"
      assert.equal obj.test("123"), "a string!"


  describe 'simple using', ->
    it 'no attributes, only string content ', ->
      html = htmlMake ->
        @div "world"

      assert.equal html, "<div>world</div>"

    it 'setts attributes (class) and handler with content', ->
      html = htmlMake ->
        @div class: "hello",  ->
          "world"

      assert.equal html, "<div class='hello'>world</div>"


    it 'setts attributes (id) and with content', ->
      html = htmlMake ->
        @div id: "hello", "world"

      assert.equal html, "<div id='hello'>world</div>"


    it 'no attributes, only handler with content ', ->
      html = htmlMake ->
        @div ->
          "world"

      assert.equal html, "<div>world</div>"


    it 'another tag type', ->
      html = htmlMake ->
        @span "span world"

      assert.equal html, "<span>span world</span>"

      html = htmlMake ->
        @li "li world"

      assert.equal html, "<li>li world</li>"

  describe 'nested structure', ->
    it 'ul with li', ->
      html = htmlMake ->
        @ul ->
          @li "one"
          @li "two"
          @li "three"

      assert.equal html, "<ul><li>one</li><li>two</li><li>three</li></ul>"
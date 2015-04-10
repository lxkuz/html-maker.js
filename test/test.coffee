assert = require "assert"
htmlMake = require "../html-maker"

describe 'Begin testing of html-maker', ->
  describe 'simple using', ->
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


    it 'no attributes, only string content ', ->
      html = htmlMake ->
        @div "world"

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

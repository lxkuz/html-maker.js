// Generated by CoffeeScript 1.9.1
(function() {
  var assert, helper, htmlMake;

  assert = require("assert");

  htmlMake = require("src/html-maker");

  helper = require("src/helper");

  describe('Begin testing of html-maker', function() {
    describe('infrastructure testing', function() {
      it('partial method testing', function() {
        var a, b, c, i, len, name, obj, ref;
        a = function(a, b, c) {
          return "" + a + b + c;
        };
        b = helper.partial(a, 1, 2);
        c = helper.partial(a, 9);
        assert.equal(b("3"), "123");
        assert.equal(c("7", "8"), "978");
        obj = {};
        ref = ["hello", "world"];
        for (i = 0, len = ref.length; i < len; i++) {
          name = ref[i];
          obj[name] = helper.partial(a, name);
        }
        assert.equal(obj.hello("3", "1"), "hello31");
        return assert.equal(obj.world("3", "1"), "world 31");
      });
      it('"use" method testing', function() {
        var a, func;
        a = {
          b: 233
        };
        func = function() {
          return this["b"];
        };
        return assert.equal(helper.use(func, a), 233);
      });
      return it("pattern matching", function() {
        var obj;
        obj = {};
        helper.definePattern(obj, "test", ["string"], function() {
          return "a string!";
        });
        helper.definePattern(obj, "test", ["object", "string"], function() {
          return "object and string!";
        });
        assert.equal(obj.test({}, "123", 123), "object and string!");
        assert.equal(obj.test({}, "123"), "object and string!");
        assert.equal(obj.test("123", 123, {}), "a string!");
        return assert.equal(obj.test("123"), "a string!");
      });
    });
    describe('simple using', function() {
      it('no attributes, only string content ', function() {
        var html;
        html = htmlMake(function() {
          return this.div("world");
        });
        return assert.equal(html, "<div>world</div>");
      });
      it('setts attributes (class) and handler with content', function() {
        var html;
        html = htmlMake(function() {
          return this.div({
            "class": "hello"
          }, function() {
            return "world";
          });
        });
        return assert.equal(html, "<div class='hello'>world</div>");
      });
      it('setts attributes (id) and with content', function() {
        var html;
        html = htmlMake(function() {
          return this.div({
            id: "hello"
          }, "world");
        });
        return assert.equal(html, "<div id='hello'>world</div>");
      });
      it('no attributes, only handler with content ', function() {
        var html;
        html = htmlMake(function() {
          return this.div(function() {
            return "world";
          });
        });
        return assert.equal(html, "<div>world</div>");
      });
      return it('another tag type', function() {
        var html;
        html = htmlMake(function() {
          return this.span("span world");
        });
        assert.equal(html, "<span>span world</span>");
        html = htmlMake(function() {
          return this.li("li world");
        });
        return assert.equal(html, "<li>li world</li>");
      });
    });
    return describe('nested structure', function() {
      return it('ul with li', function() {
        var html;
        html = htmlMake(function() {
          return this.ul(function() {
            this.li("one");
            this.li("two");
            return this.li("three");
          });
        });
        return assert.equal(html, "<ul><li>one</li><li>two</li><li>three</li></ul>");
      });
    });
  });

}).call(this);

//# sourceMappingURL=test.js.map

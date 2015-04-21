// Generated by CoffeeScript 1.9.2
(function() {
  var assert, helper, htmlmake;

  assert = require("assert");

  htmlmake = require("src/html-maker");

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
        return assert.equal(obj.world("3", "1"), "world31");
      });
      return it('"use" method testing', function() {
        var a, func;
        a = {
          b: 233
        };
        func = function() {
          return this["b"];
        };
        return assert.equal(helper.use(func, a), 233);
      });
    });
    describe('simple using', function() {
      it("should return result of main handler", function() {
        var html;
        html = htmlmake(function() {
          return "returns!";
        });
        assert.equal(html, "returns!");
        html = htmlmake(function() {
          this.span();
          return "returns!";
        });
        return assert.equal(html, "<span></span>returns!");
      });
      it('no attributes, only string content ', function() {
        var html;
        html = htmlmake(function() {
          return this.div("world");
        });
        return assert.equal(html, "<div>world</div>");
      });
      it('setts attributes (class) and handler with content', function() {
        var html;
        html = htmlmake(function() {
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
        html = htmlmake(function() {
          return this.div({
            id: "hello"
          }, "world");
        });
        return assert.equal(html, "<div id='hello'>world</div>");
      });
      it('no attributes, only handler with content ', function() {
        var html;
        html = htmlmake(function() {
          return this.div(function() {
            return "world";
          });
        });
        return assert.equal(html, "<div>world</div>");
      });
      return it('another tag type', function() {
        var html;
        html = htmlmake(function() {
          return this.span("span world");
        });
        assert.equal(html, "<span>span world</span>");
        html = htmlmake(function() {
          return this.li("li world");
        });
        return assert.equal(html, "<li>li world</li>");
      });
    });
    describe('nested structure', function() {
      it('ul with li', function() {
        var html;
        html = htmlmake(function() {
          return this.ul(function() {
            this.li("one");
            this.li("two");
            return this.li("three");
          });
        });
        return assert.equal(html, "<ul><li>one</li><li>two</li><li>three</li></ul>");
      });
      it('multiple elements', function() {
        var html;
        html = htmlmake(function() {
          this.span({
            id: "first"
          }, "1");
          this.span({
            "class": "second"
          }, "2");
          return this.a({
            href: "http://google.com"
          }, "Hello");
        });
        return assert.equal(html, "<span id='first'>1</span><span class='second'>2</span><a href='http://google.com'>Hello</a>");
      });
      return it("level: hard", function() {
        var data, html;
        data = {
          name: "Alexey",
          age: 25
        };
        html = htmlmake(function() {
          this.div("header", function() {
            this.span({
              id: "first"
            }, "1");
            this.span({
              "class": "second"
            }, "2");
            return this.a({
              href: "http://google.com"
            }, function() {
              return this.h1("Hello");
            });
          });
          return this.div({
            "class": "body",
            id: "-body-container"
          }, function() {
            return this.ul(function() {
              this.li(function() {
                return "Hello, " + data.name + "!";
              });
              this.li("one", "Your age is - " + data.age);
              return this.li();
            });
          });
        });
        return assert.equal(html, "<div class='header'>" + "<span id='first'>1</span>" + "<span class='second'>2</span>" + "<a href='http://google.com'><h1>Hello</h1></a>" + "</div>" + "<div class='body' id='-body-container'>" + "<ul>" + "<li>Hello, Alexey!</li>" + "<li class='one'>Your age is - 25</li>" + "<li></li>" + "</ul>" + "</div>");
      });
    });
    return describe("using own context", function() {
      it("should works with build variable, simple div", function() {
        var html;
        html = htmlmake(function(mk) {
          return mk.div("hello");
        });
        return assert.equal(html, "<div>hello</div>");
      });
      it("should works with build variable, nested structure", function() {
        var html;
        html = htmlmake(function(mk) {
          return mk.div({
            "class": "hello"
          }, function(mk) {
            return mk.span("world");
          });
        });
        return assert.equal(html, "<div class='hello'><span>world</span></div>");
      });
      return it("final test: custom 'this'", function() {
        var html;
        this.hello = "world";
        html = htmlmake((function(_this) {
          return function(mk) {
            mk.span(_this.hello);
            return mk.div({
              "class": "hello"
            }, function(mk) {
              return mk.span(_this.hello);
            });
          };
        })(this));
        return assert.equal(html, "<span>world</span><div class='hello'><span>world</span></div>");
      });
    });
  });

}).call(this);

//# sourceMappingURL=test.js.map

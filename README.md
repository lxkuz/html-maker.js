# html-maker.js
If you need to make some html, but you do not want to use jQuery spaghetti code or html template engines. 
Best way is to use this lib with coffescript syntax. 

Let's create some dom elements...

# Simple usage

```coffescript
  html = htmlmake ->
    @div "hello!"
    @span id: "super", "world!"
    
```
It returns:
```html
  <div>Hello</div
  <span id="super">world!</span>
```

# Nesting structure

```coffescript
  html = htmlmake ->
    @div "hello-class", ->
      @ul ->
        @li "one"
        @li "two"
        @li "three"
      @a href: "http://google.com", "underworld!"
    
```
It returns:
```html
  <div class='hello-class'>
    <ul>
      <li>one</li>
      <li>two</li>
      <li>tree</li>
    </ul>
    <a href="http://google.com"">underworld!</a>
  </div>
```

Enjoy!

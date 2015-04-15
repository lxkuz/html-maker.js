coffee --map --compile --output src src/*.coffee

cjsify -o build/helper.js  src/helper.js
cjsify -o build/html-maker.js  src/html-maker.js
uglifyjs -o build/htmlmake.min.js -d build/*.js


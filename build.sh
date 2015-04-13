coffee --map --compile --output build src/*.coffee
cjsify -o build/helper.js  build/helper.js
cjsify -o build/html-maker.js  build/html-maker.js
uglifyjs -o html-maker.js build/*.js


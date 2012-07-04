fs     = require('fs')
exec   = require('child_process').exec
path   = require('path')
print  = require('util').print
coffee = require('coffee-script')
uglify = require('uglify-js')

build = (minify = false) ->
  coffeeSource = fs.readFileSync('src/echo.coffee') + ''
  jsSource = coffee.compile(coffeeSource)

  fs.writeFileSync("build/echo.js", jsSource)

  ast = uglify.parser.parse(jsSource)
  ast = uglify.uglify.ast_mangle(ast)
  ast = uglify.uglify.ast_squeeze(ast)
  jsMin = uglify.uglify.gen_code(ast)

  fs.writeFileSync("build/echo.min.js", jsMin)

task 'build', 'Builds echo.js file', ->
  print "Building...\n"
  build()
  print "Done.\n"

task 'test', 'Start tests', ->
  exec './node_modules/mocha/bin/mocha ./spec/echo_spec.coffee --compilers coffee:coffee-script -R spec -c', (error, stdout, stderr) ->
    print stdout
    print stderr
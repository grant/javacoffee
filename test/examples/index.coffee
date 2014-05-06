fs = require 'fs'
async = require 'async'

examples = [
  # 'HelloWorld'
  # 'EnhancedFor'
  # 'Factorial'
  # 'LiteralJava'
  # 'Methods'
  # 'RectanglePointer'
]

describe 'examples', ->
  compiler = require '../../src/compiler'

  for exampleName in examples
    javaCoffeePath = __dirname + '/' + exampleName + '.jc'
    javaPath = __dirname + '/' + exampleName + '.java'

    if fs.existsSync(javaCoffeePath) and fs.existsSync(javaPath)
      # Files exist, so get the contents
      async.parallel [
          (callback) ->
            callback null, fs.readFileSync javaCoffeePath, 'utf8'
          (callback) ->
            callback null, fs.readFileSync javaPath, 'utf8'
        ], (err, results) ->
          javaCoffeeContent = results[0]
          expectedJavaContent = results[1]
          compiler.compileJavaCoffee javaCoffeePath, javaCoffeeContent, (actualJavaContent) ->
            it exampleName, ->
              expected = expectedJavaContent.split('\n')
              actual = actualJavaContent.split('\n')
              actual.should.equal(expected)
    else
      # Something went wrong with the files
      console.error "There's something wrong with the file paths"
      console.log 'jc: ' + javaCoffeePath
      console.log 'java: ' + javaPath
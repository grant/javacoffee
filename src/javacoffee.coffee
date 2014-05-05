path = require 'path'
fs = require 'fs'
compiler = require './compiler'

# Gets the path of a compiled file
getCompiledPath = (filePath, extname) ->
  pathExtension = path.extname filePath
  endIndex = filePath.length - pathExtension.length
  return filePath.substring(0, endIndex) + '.' + extname

# Compiles a file given the arguments
compile = ->
  if process.argv.length > 2
    javaCoffeePath = process.argv[2]
    if fs.existsSync javaCoffeePath
      # Get contents
      content = fs.readFileSync(javaCoffeePath, 'utf8')

      # Compile .jc -> .java
      compiler.compileJavaCoffee(javaCoffeePath, content, (javaContent) ->
        # Save .java
        javaPath = getCompiledPath javaCoffeePath, 'java'
        fs.writeFileSync javaPath, javaContent
        console.log 'Done. (' + javaCoffeePath + ') -> (' + javaPath + ')'

        # Compile .java -> .class
        compiler.compileJava(javaPath, javaContent, (classContent) ->
          classPath = getCompiledPath javaPath, 'class'
          console.log 'Done. (' + javaPath + ') -> (' + classPath + ')'
        )
      )
    else
      console.log 'File does not exist - ' + javaCoffeePath
  else
    console.log 'Pass on a file name/path'
  return

exports.compile = compile
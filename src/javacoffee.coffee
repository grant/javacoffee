path = require 'path'
fs = require 'fs'
compiler = require './compiler'

# Gets the path of a compiled file
getCompiledPath = (filePath, extname) ->
  pathExtension = path.extname filePath
  return filePath.substring(0, filePath.length - pathExtension.length) + '.' + extname

# Compiles a file given the arguments
compile = ->
  if process.argv.length > 2
    filePath = process.argv[2]
    if fs.existsSync filePath
      # Get contents
      content = fs.readFileSync(filePath, 'utf8')

      # Compile .jc -> .java
      compiler.compileJavaCoffee(filePath, content, (javaContent) ->
        # Save .java
        compiledPath = getCompiledPath filePath, 'java'
        fs.writeFileSync compiledPath, javaContent
        console.log 'Done. (' + filePath + ') -> (' + compiledPath + ')'
        
        # # Compile .java -> .class
        # compiledPath = getCompiledPath filePath, 'class'
        # fs.writeFileSync compiledPath, compiledContent
        # console.log 'Done. (' + filePath + ') -> (' + compiledPath + ')'
      )
    else
      console.log 'File does not exist - ' + filePath
  else
    console.log 'Pass on a file name/path'
  return

exports.compile = compile
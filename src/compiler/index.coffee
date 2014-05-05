# Requires
exec = require('child_process').exec
S = require 'string'
parser = require '../parser'

# Compiler
compiler =
  # .jc -> .java
  compileJavaCoffee: (filePath, content, cb) ->
    lines = S(content).lines()
    parser.parseLines lines
    cb lines.join '\n'

  # .java -> .class
  compileJava: (filePath, content, cb) ->
    command = 'javac ' + filePath
    exec(command, (error, stdout, stderr) ->
      # Nothing to do here... javac will log errors automatically
      cb()
    )

module.exports = compiler
# Requires
exec = require('child_process').exec

# Compiler
compiler =
  # .jc -> .java
  compileJavaCoffee: (filePath, content, cb) ->
    cb(content)

  # .java -> .class
  compileJava: (filePath, content, cb) ->
    command = 'javac ' + filePath
    exec(command, (error, stdout, stderr) ->
      # Nothing to do here... javac will log errors automatically
      cb()
    )

module.exports = compiler
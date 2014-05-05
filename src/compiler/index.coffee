# Requires
exec = require('child_process').exec

# Compiler
compiler =
  compileJavaCoffee: (filePath, content, cb) ->
    # .jc -> .java

  compileJava: (filePath, content, cb) ->
    # .java -> .class
    command = 'javac ' + filePath
    exec(command, (error, stdout, stderr) ->
      console.log "stdout: " + stdout
      console.log "stderr: " + stderr
      console.log "exec error: " + error  if error isnt null
      cb(stdout)
    )

module.exports = compiler
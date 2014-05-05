# Requires
exec = require('child_process').exec

# Compiler
compiler =
  compile: (content, cb) ->
    exec("ls", (error, stdout, stderr) ->
      console.log "stdout: " + stdout
      console.log "stderr: " + stderr
      console.log "exec error: " + error  if error isnt null
      cb(stdout)
    )

module.exports = compiler
fs = require("fs")

# Right now it just makes the file passed-in uppercased
compile = ->
  if process.argv.length > 2
    myfile = process.argv[2]
    if fs.existsSync(myfile)
      content = fs.readFileSync(myfile, "utf8")
      fs.writeFileSync myfile, content.toUpperCase()
      console.log "Done"
    else
      console.log "File does not exist - " + myfile
  else
    console.log "Pass on a file name/path"
  return

exports.compile = compile
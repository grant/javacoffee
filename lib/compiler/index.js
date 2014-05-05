(function() {
  var compiler, exec;

  exec = require('child_process').exec;

  compiler = {
    compileJavaCoffee: function(filePath, content, cb) {},
    compileJava: function(filePath, content, cb) {
      var command;
      command = 'javac ' + filePath;
      return exec(command, function(error, stdout, stderr) {
        console.log("stdout: " + stdout);
        console.log("stderr: " + stderr);
        if (error !== null) {
          console.log("exec error: " + error);
        }
        return cb(stdout);
      });
    }
  };

  module.exports = compiler;

}).call(this);

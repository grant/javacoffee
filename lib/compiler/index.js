(function() {
  var compiler, exec;

  exec = require('child_process').exec;

  compiler = {
    compile: function(content, cb) {
      return exec("ls", function(error, stdout, stderr) {
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

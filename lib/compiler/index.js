(function() {
  var compiler, exec;

  exec = require('child_process').exec;

  compiler = {
    compileJavaCoffee: function(filePath, content, cb) {
      return cb(content);
    },
    compileJava: function(filePath, content, cb) {
      var command;
      command = 'javac ' + filePath;
      return exec(command, function(error, stdout, stderr) {
        return cb();
      });
    }
  };

  module.exports = compiler;

}).call(this);

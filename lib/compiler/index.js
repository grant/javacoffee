(function() {
  var compiler, exec, parser;

  exec = require('child_process').exec;

  parser = require('../parser');

  compiler = {
    compileJavaCoffee: function(filePath, content, cb) {
      parser.parse(content);
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

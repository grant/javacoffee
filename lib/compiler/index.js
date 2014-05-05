(function() {
  var S, compiler, exec, parser;

  exec = require('child_process').exec;

  S = require('string');

  parser = require('../parser');

  compiler = {
    compileJavaCoffee: function(filePath, content, cb) {
      var lines;
      lines = S(content).lines();
      parser.parseLines(lines);
      return cb(lines.join('\n'));
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

(function() {
  var compile, compiler, fs, getCompiledPath, path;

  path = require('path');

  fs = require('fs');

  compiler = require('./compiler');

  getCompiledPath = function(filePath, extname) {
    var endIndex, pathExtension;
    pathExtension = path.extname(filePath);
    endIndex = filePath.length - pathExtension.length;
    return filePath.substring(0, endIndex) + '.' + extname;
  };

  compile = function() {
    var content, javaCoffeePath;
    if (process.argv.length > 2) {
      javaCoffeePath = process.argv[2];
      if (fs.existsSync(javaCoffeePath)) {
        content = fs.readFileSync(javaCoffeePath, 'utf8');
        compiler.compileJavaCoffee(javaCoffeePath, content, function(javaContent) {
          var javaPath;
          javaPath = getCompiledPath(javaCoffeePath, 'java');
          fs.writeFileSync(javaPath, javaContent);
          console.log('Done. (' + javaCoffeePath + ') -> (' + javaPath + ')');
          return compiler.compileJava(javaPath, javaContent, function(classContent) {
            var classPath;
            classPath = getCompiledPath(javaPath, 'class');
            return console.log('Done. (' + javaPath + ') -> (' + classPath + ')');
          });
        });
      } else {
        console.log('File does not exist - ' + javaCoffeePath);
      }
    } else {
      console.log('Pass on a file name/path');
    }
  };

  exports.compile = compile;

}).call(this);

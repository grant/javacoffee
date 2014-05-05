(function() {
  var compile, compiler, fs, getCompiledPath, path;

  path = require('path');

  fs = require('fs');

  compiler = require('./compiler');

  getCompiledPath = function(filePath) {
    var pathExtension;
    pathExtension = path.extname(filePath);
    return filePath.substring(0, filePath.length - pathExtension.length) + '.class';
  };

  compile = function() {
    var content, filePath;
    if (process.argv.length > 2) {
      filePath = process.argv[2];
      if (fs.existsSync(filePath)) {
        content = fs.readFileSync(filePath, 'utf8');
        compiler.compile(content, function(compiledContent) {
          var compiledPath;
          compiledPath = getCompiledPath(filePath);
          fs.writeFileSync(compiledPath, compiledContent);
          return console.log('Done. (' + filePath + ') -> (' + compiledPath + ')');
        });
      } else {
        console.log('File does not exist - ' + filePath);
      }
    } else {
      console.log('Pass on a file name/path');
    }
  };

  exports.compile = compile;

}).call(this);

(function() {
  var comment, inComment, parseLines;

  comment = require('./comment');

  inComment = false;

  parseLines = function(lines) {
    var hi, line, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      if (!inComment) {
        _results.push(hi = 1);
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  module.exports = {
    parseLines: parseLines
  };

}).call(this);

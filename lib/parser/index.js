(function() {
  var comment, inClass, inMethod, inMultiLineComment, inSingleLineComment, methodStack, parseLines, tokenizer;

  comment = require('./comment');

  tokenizer = require('./tokenizer');

  inSingleLineComment = false;

  inMultiLineComment = false;

  inClass = false;

  inMethod = false;

  methodStack = [];

  parseLines = function(lines) {
    var line, tokens, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      _results.push(tokens = tokenizer.getTokens(line));
    }
    return _results;
  };

  module.exports = {
    parseLines: parseLines
  };

}).call(this);

(function() {
  var comment, methodStack, parseLines, programState, tokenizer;

  comment = require('./comment');

  tokenizer = require('./tokenizer');

  programState = {
    inSingleLineComment: false,
    inMultiLineComment: false,
    inClass: false,
    inMethod: false
  };

  methodStack = [];

  parseLines = function(lines) {
    var line, tokens, _i, _len;
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      tokens = tokenizer.getTokens(line, programState);
    }
    return lines;
  };

  module.exports = {
    parseLines: parseLines
  };

}).call(this);

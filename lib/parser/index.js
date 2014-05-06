(function() {
  var comment, methodStack, parse, programState, tokenizer;

  comment = require('./comment');

  tokenizer = require('./tokenizer');

  programState = {
    inSingleLineComment: false,
    inMultiLineComment: false,
    inClass: false,
    inMethod: false
  };

  methodStack = [];

  parse = function(content) {
    var tokens;
    tokens = tokenizer.getTokensByLine(content);
    return content;
  };

  module.exports = {
    parse: parse
  };

}).call(this);

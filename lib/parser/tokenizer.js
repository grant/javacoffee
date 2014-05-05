(function() {
  var getBeginningWhitespace, keywords, startsWithKeyword;

  keywords = ['class', 'main', 'if', 'else', 'print', 'println'];

  startsWithKeyword = function(line) {
    var keyword, _i, _len;
    for (_i = 0, _len = keywords.length; _i < _len; _i++) {
      keyword = keywords[_i];
      line += ' ';
      if (line.substring(0, keyword.length + 1) === keyword + ' ') {
        return keyword;
      }
    }
  };

  getBeginningWhitespace = function(line) {
    var i, whitespace;
    whitespace = '';
    i = 0;
    while (line !== '' && line.charAt(i).trim() === '') {
      whitespace += line.charAt(i);
      ++i;
    }
    return whitespace;
  };

  module.exports = {
    getTokens: function(line) {
      var beginningWhitespace, startingKeyword, tokens;
      tokens = [];
      beginningWhitespace = getBeginningWhitespace(line);
      if (beginningWhitespace) {
        tokens.push(beginningWhitespace);
      }
      line = line.substring(beginningWhitespace.length);
      startingKeyword = startsWithKeyword(line);
      if (startingKeyword) {
        tokens.push(startingKeyword);
        line = line.substring(startingKeyword.length);
      }
      beginningWhitespace = getBeginningWhitespace(line);
      if (beginningWhitespace) {
        tokens.push(beginningWhitespace);
      }
      line = line.substring(beginningWhitespace.length);
      tokens.push(line);
      return tokens;
    }
  };

}).call(this);

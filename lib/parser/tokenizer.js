(function() {
  var KEYWORDS, char, getBeginningWhitespace, startsWithKeyword;

  char = require('./char');

  KEYWORDS = ['abstract', 'boolean', 'break', 'byte', 'class', 'do', 'double', 'else', 'extends', 'float', 'for', 'if', 'implements', 'instanceof', 'int', 'interface', 'long', 'main', 'print', 'println', 'return', 'short', 'switch', 'throw', 'throws', 'try', 'while'];

  startsWithKeyword = function(string, keyword) {
    var startingKeyword, trimmedString, _i, _len;
    if (keyword) {
      trimmedString = string.trim();
      if (trimmedString.length === keyword.length) {
        if (trimmedString === keyword) {
          return keyword;
        } else {
          return false;
        }
      }
      if (char.isLetter(trimmedString.charAt(keyword.length + 1))) {
        return false;
      } else {
        return true;
      }
    } else {
      for (_i = 0, _len = KEYWORDS.length; _i < _len; _i++) {
        keyword = KEYWORDS[_i];
        startingKeyword = startsWithKeyword(string, keyword);
        if (startingKeyword) {
          return startingKeyword;
        }
      }
      return false;
    }
  };

  getBeginningWhitespace = function(string) {
    var i, whitespace;
    whitespace = '';
    i = 0;
    while (string !== '' && string.charAt(i).trim() === '') {
      whitespace += string.charAt(i);
      ++i;
    }
    return whitespace;
  };

  module.exports = {
    KEYWORDS: KEYWORDS,
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
      return [];
    }
  };

}).call(this);

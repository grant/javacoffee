(function() {
  var KEYWORDS, S, char, getBeginningWhitespace, getTokensByLine, getTokensInLine, opensMultilineComment, startsWithKeyword;

  char = require('./char');

  S = require('string');

  KEYWORDS = ['abstract', 'boolean', 'break', 'byte', 'do', 'double', 'else', 'extends', 'float', 'for', 'if', 'implements', 'instanceof', 'int', 'interface', 'long', 'main', 'print', 'println', 'return', 'short', 'switch', 'throw', 'throws', 'try', 'while'];

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

  opensMultilineComment = function(line) {
    var endCommentIndex, inMultiLineComment, multilineCommentIndex, singleLineCommentIndex;
    if (line.indexOf('/*') === -1) {
      return false;
    }
    inMultiLineComment = false;
    while (line) {
      if (inMultiLineComment) {
        endCommentIndex = line.indexOf('*/');
        if (endCommentIndex === -1) {
          line = '';
        } else {
          line = line.substring(endCommentIndex + 2);
          inMultiLineComment = false;
        }
      } else {
        singleLineCommentIndex = line.indexOf('//');
        if (singleLineCommentIndex === -1) {
          singleLineCommentIndex = line.indexOf('#');
        }
        multilineCommentIndex = line.indexOf('/*');
        if ((singleLineCommentIndex !== -1) && (multilineCommentIndex !== -1) && (singleLineCommentIndex < multilineCommentIndex)) {
          line = '';
        } else {
          line = line.substring(line.indexOf('/'));
          if (line.substring(0, 2) === '/*') {
            inMultiLineComment = true;
            line = line.substring(2);
          } else {
            line = line.substring(1);
          }
        }
      }
    }
    return inMultiLineComment;
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

  getTokensByLine = function(content) {
    var inMultiLineComment, line, lineTokens, lines, _i, _len;
    inMultiLineComment = false;
    lines = S(content).lines();
    lineTokens = [];
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      lineTokens = getTokensInLine(line, inMultiLineComment);
      inMultiLineComment = opensMultilineComment(line);
    }
    return lineTokens;
  };

  getTokensInLine = function(line, inMultiLineComment) {
    var beginningWhitespace, startingKeyword, tokens;
    tokens = [];
    if (inMultiLineComment) {
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
    } else {

    }
    return [];
  };

  module.exports = {
    KEYWORDS: KEYWORDS,
    getTokensByLine: getTokensByLine,
    getTokensInLine: getTokensInLine,
    opensMultilineComment: opensMultilineComment
  };

}).call(this);

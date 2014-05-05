(function() {
  module.exports = {
    isSingleLineComment: function(token) {
      return line.trim().substring(0, 2) === '//';
    },
    startsMultiLineComment: function(token) {
      return true;
    }
  };

}).call(this);

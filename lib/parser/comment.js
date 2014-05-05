(function() {
  module.exports = {
    isSingleLineComment: function(line) {
      return line.trim().substring(0, 2) === '//';
    },
    startsMultiLineComment: function(line) {
      return true;
    }
  };

}).call(this);

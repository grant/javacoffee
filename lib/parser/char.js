(function() {
  var LETTER_REGEX;

  LETTER_REGEX = /[A-Za-z]/;

  module.exports = {
    isLetter: function(char) {
      return char.length === 1 && LETTER_REGEX.test(char);
    }
  };

}).call(this);

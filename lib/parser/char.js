(function() {
  module.exports = {
    isLetter: function(char) {
      return char.length === 1 && char.toLowerCase().match(/[a-z]/i);
    }
  };

}).call(this);

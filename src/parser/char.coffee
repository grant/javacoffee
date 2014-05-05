LETTER_REGEX = /[A-Za-z]/

module.exports =
  isLetter: (char) ->
    return char.length == 1 && LETTER_REGEX.test(char)
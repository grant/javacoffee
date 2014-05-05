module.exports =
  isLetter: (char) ->
    return char.length == 1 && char.toLowerCase().match(/[a-z]/i)
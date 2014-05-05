module.exports =
  isSingleLineComment: (token) ->
    return line.trim().substring(0, 2) == '//'

  startsMultiLineComment: (token) ->
    return true
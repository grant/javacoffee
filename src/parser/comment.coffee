module.exports =
  isSingleLineComment: (line) ->
    return line.trim().substring(0, 2) == '//'

  startsMultiLineComment: (line) ->
    return true
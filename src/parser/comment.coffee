module.exports =
  isSingleLineComment: (token) ->
    return token.trim().substring(0, 2) == '//'

  startsMultiLineComment: (token) ->
    return true
keywords = [
  'class'
  'main'
  'if'
  'else'
  'print'
  'println'
]

# Gets the keyword it starts with (if it does)
startsWithKeyword = (line) ->
  for keyword in keywords
    line += ' '
    return keyword if line.substring(0, keyword.length + 1) == keyword + ' '

# Gets beginning whitespace
getBeginningWhitespace = (line) ->
  whitespace = ''
  i = 0
  while line != '' and line.charAt(i).trim() == ''
    whitespace += line.charAt(i)
    ++i
  return whitespace

module.exports =
  getTokens: (line) ->
    tokens = []
    # Beginning whitespace
    beginningWhitespace = getBeginningWhitespace line
    tokens.push beginningWhitespace if beginningWhitespace
    line = line.substring beginningWhitespace.length

    # Beginning keyword
    startingKeyword = startsWithKeyword line
    if startingKeyword
      tokens.push startingKeyword
      line = line.substring startingKeyword.length

    # Whitespace
    beginningWhitespace = getBeginningWhitespace line
    tokens.push beginningWhitespace if beginningWhitespace
    line = line.substring beginningWhitespace.length

    tokens.push line
    return tokens
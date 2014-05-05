char = require './char'

KEYWORDS = [
  'abstract'
  'boolean'
  'break'
  'byte'
  'class'
  'do'
  'double'
  'else'
  'extends'
  'float'
  'for'
  'if'
  'implements'
  'instanceof'
  'int'
  'interface'
  'long'
  'main'
  'print'
  'println'
  'return'
  'short'
  'switch'
  'throw'
  'throws'
  'try'
  'while'
]

# Gets the keyword it starts with (if it does)
startsWithKeyword = (string, keyword) ->
  # 1 argument
  if keyword
    trimmedString = string.trim()
    if trimmedString.length == keyword.length
      if trimmedString == keyword
        return keyword
      else
        return false
    # If the character after the string is a letter, return false
    if char.isLetter(trimmedString.charAt(keyword.length + 1))
      return false
    else
      return true
  # 2 arguments
  else
    # Return the keyword if found
    for keyword in KEYWORDS
      startingKeyword = startsWithKeyword string, keyword
      return startingKeyword if startingKeyword
    return false

# Gets beginning whitespace
getBeginningWhitespace = (string) ->
  whitespace = ''
  i = 0
  while string != '' and string.charAt(i).trim() == ''
    whitespace += string.charAt(i)
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
  KEYWORDS: KEYWORDS
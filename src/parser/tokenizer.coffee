char = require './char'
S = require 'string'

KEYWORDS = [
  'abstract'
  'boolean'
  'break'
  'byte'
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

# Gets if a line opens a multiline comment
opensMultilineComment = (line) ->
  if line.indexOf('/*') == -1
    return false
  # Start cutting off beginning of line
  inMultiLineComment = false
  while line
    if inMultiLineComment
      endCommentIndex = line.indexOf('*/')
      if endCommentIndex == -1
        line = ''
      else
        line = line.substring(endCommentIndex + 2)
        inMultiLineComment = false
    else # Not in multiline comment
      singleLineCommentIndex = line.indexOf('//')
      if singleLineCommentIndex == -1
        singleLineCommentIndex = line.indexOf('#')
      multilineCommentIndex = line.indexOf('/*')
      if (singleLineCommentIndex != -1) and (multilineCommentIndex != -1) and (singleLineCommentIndex < multilineCommentIndex)
        line = ''
      else
        line = line.substring(line.indexOf('/'))
        if line.substring(0, 2) == '/*'
          inMultiLineComment = true
          line = line.substring(2)
        else
          line = line.substring(1)
  return inMultiLineComment

# Gets beginning whitespace
getBeginningWhitespace = (string) ->
  whitespace = ''
  i = 0
  while string != '' and string.charAt(i).trim() == ''
    whitespace += string.charAt(i)
    ++i
  return whitespace

# Gets an array of line tokens
getTokensByLine = (content) ->
  inMultiLineComment = false
  lines = S(content).lines()
  lineTokens = []

  # Go through each line
  for line in lines
    # Tokenize the line
    lineTokens = getTokensInLine line, inMultiLineComment
    # Get if the line opens a multiline comment
    inMultiLineComment = opensMultilineComment line
  return lineTokens

# Gets tokens in a line
getTokensInLine = (line, inMultiLineComment) ->
  tokens = []
  if inMultiLineComment
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
  else # Not in multiline comment
    # Stuff...
  return []

# Exports
module.exports =
  KEYWORDS: KEYWORDS
  getTokensByLine: getTokensByLine
  getTokensInLine: getTokensInLine
  opensMultilineComment: opensMultilineComment
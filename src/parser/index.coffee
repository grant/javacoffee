# Requires
comment = require './comment'
tokenizer = require './tokenizer'

programState =
  inSingleLineComment: false
  inMultiLineComment: false
  inClass: false
  inMethod: false

methodStack = []

# converts the content of .jc to .java
parse = (content) ->
  # Get all the tokens
  tokens = tokenizer.getTokens content
  # Go through the tokens line by line and translate

  # Join the translated lines
  return content

module.exports =
  parse: parse
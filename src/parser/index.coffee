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
  # tokens = tokenizer.getTokens line, programState
  # for token in tokens
  return content

module.exports =
  parse: parse
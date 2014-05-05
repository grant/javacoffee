# Requires
comment = require './comment'
tokenizer = require './tokenizer'

programState =
  inSingleLineComment: false
  inMultiLineComment: false
  inClass: false
  inMethod: false

methodStack = []

# converts the lines from .jc to .java
parseLines = (lines) ->
  for line in lines
    tokens = tokenizer.getTokens line, programState
    # for token in tokens
  return lines

module.exports =
  parseLines: parseLines
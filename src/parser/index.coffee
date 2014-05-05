# Requires
comment = require './comment'
tokenizer = require './tokenizer'

inSingleLineComment = false
inMultiLineComment = false
inClass = false
inMethod = false
methodStack = []

parseLines = (lines) ->
  for line in lines
    tokens = tokenizer.getTokens line
    # for token in tokens

module.exports =
  parseLines: parseLines
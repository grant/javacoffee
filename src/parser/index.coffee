# Requires
comment = require './comment'

inComment = false

parseLines = (lines) ->
  for line in lines
    if !inComment
      hi = 1

module.exports =
  parseLines: parseLines
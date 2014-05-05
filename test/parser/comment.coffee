comment = require '../../src/parser/comment'

describe 'comment', ->
  describe 'single line comment', ->
    it 'should work with empty string', ->
      comment.isSingleLineComment('').should.be.false
    it 'should work with a comment with spaces', ->
      comment.isSingleLineComment('   //  ').should.be.true
    it 'should not allow // to be separated', ->
      comment.isSingleLineComment('/ /').should.be.false
  describe 'multi line comment', ->
    describe 'comment start', ->
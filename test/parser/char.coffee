char = require '../../src/parser/char'

describe 'char', ->
  describe 'isLetter', ->
    it 'should accept lowercase', ->
      char.isLetter('f').should.be.true
    it 'should accept uppercase', ->
      char.isLetter('Z').should.be.true
    it 'should reject letters', ->
      char.isLetter('4').should.be.false
    it 'should reject strings of length > 1', ->
      char.isLetter('aa').should.be.false
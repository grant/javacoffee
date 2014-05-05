tokenizer = require '../../src/parser/tokenizer'
KEYWORDS = tokenizer.KEYWORDS

describe 'tokenizer', ->
  # describe 'startsWithKeyword', ->
  #   it ''
  describe 'getTokens', ->
    describe 'class', ->
      it 'should work with starting whitespace', ->
        tokenizer.getTokens('   class Tester').should.equal(['   ', 'class', ' ', 'Tester'])
      it 'should work with trailing whitespace', ->
        tokenizer.getTokens('   class Tester    ').should.equal(['   ', 'class', ' ', 'Tester', '    '])
      it 'should work with single line comments no space', ->
        tokenizer.getTokens('class Tester# test blah').should.equal(['class',' ','Tester','# test blah'])
      it 'should work with single line comments with space', ->
        tokenizer.getTokens('class Tester    # test blah').should.equal(['class',' ','Tester','    ','# test blah'])
      it 'should work with multi line comments with space no end', ->
        tokenizer.getTokens('class Tester    /* test blah').should.equal(['class',' ','Tester','    ','/* test blah'])
      it 'should work with multi line comments with space with end', ->
        tokenizer.getTokens('class Tester    /* test blah */  ').should.equal(['class',' ','Tester','    ','/* test blah */', '  '])
      it 'should work with multi line comments with space with end with single line', ->
        tokenizer.getTokens('class Tester    /* test blah */  # another comment').should.equal(['class',' ','Tester','    ','/* test blah */', '  ', '# another comment'])
      it 'should work with single line comment having multi line comments', ->
        tokenizer.getTokens('class Tester    #/* test blah */').should.equal(['class',' ','Tester','    ','#/* test blah */'])
      it 'should work with embedded comments', ->
        tokenizer.getTokens('class/**/Tester').should.equal(['class', '/**/', 'Tester'])
    describe 'method', ->
      it 'should work with a basic example', ->
        tokenizer.getTokens('  main').should.equal(['  ', 'main'])
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
      it 'should separate classifiers', ->
        tokenizer.getTokens('  +run').should.equal(['  ', '+', 'run'])
      it 'should separate multiple classifiers', ->
        tokenizer.getTokens('  -&run').should.equal(['  ', '-', '&', 'run'])
      it 'should work with params', ->
        tokenizer.getTokens('  &alterPointer Rect r').should.equal(['  ', '&', 'alterPointer', ' ', 'Rect', ' ', 'r'])
      it 'should work with return type', ->
        tokenizer.getTokens('  &sumListEnhanced:int').should.equal(['  ', '&', 'sumListEnhanced', ':', 'int'])
      it 'should work with return type with spaces', ->
        tokenizer.getTokens('  &  sumListEnhanced     :    int').should.equal(['  ', '&', '  ', 'sumListEnhanced', '     ', ':', '    ', 'int'])
      it 'should work with params and return type', ->
        tokenizer.getTokens('  &sumListEnhanced int[] list :int').should.equal(['   ', '&', 'sumListEnhanced', ' ', 'int[]', ' ', 'list', ' ', ':', 'int'])
    describe 'assignment', ->
      it 'should work with a basic example', ->
        tokenizer.getTokens('    x = 3').should.equal(['    ', 'x', ' ', '=', ' ', '3'])
      it 'should work with a basic example no spaces', ->
        tokenizer.getTokens('    x=3').should.equal(['    ', 'x', '=', '3'])
      it 'should work with comments on end', ->
        tokenizer.getTokens('    x = 3#3').should.equal(['    ', 'x', ' ', '=', ' ', '3', '#3'])
      it 'should work with comments on in middle', ->
        tokenizer.getTokens('    /**/x/**/=/**/3').should.equal(['    ', '/**/', 'x', '/**/', '=', '/**/', '3'])
    describe 'string', ->
      it 'should detect strings', ->
        tokenizer.getTokens('    println "hi"').should.equal(['    ', 'println', ' ', '"hi"'])
      it 'should detect strings with single quotes', ->
        tokenizer.getTokens("    println 'hi'").should.equal(['    ', 'println', ' ', "'hi'"])
      it 'should detect strings with special character quote marks', ->
        tokenizer.getTokens('    println "h\"i"').should.equal(['    ', 'println', ' ', '"h\"i"'])
      it 'should work fine with string interpolation', ->
        tokenizer.getTokens('    println "In method alterPointer. r @r\n"').should.equal(['    ', 'println', ' ', '"In method alterPointer. r @r\n"'])
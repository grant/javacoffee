tokenizer = require '../../src/parser/tokenizer'
KEYWORDS = tokenizer.KEYWORDS

describe 'tokenizer', ->
  describe 'opensMultilineComment', ->
    it 'empty', ->
      tokenizer.opensMultilineComment('').should.be.false
    it 'whitespace', ->
      tokenizer.opensMultilineComment('    ').should.be.false
    it 'single line comment', ->
      tokenizer.opensMultilineComment('  sdf # awlekgjaweg # alk').should.be.false
    it 'single line comment with multi line comment open', ->
      tokenizer.opensMultilineComment('  sdf # /*').should.be.false
    it 'single line comment with multi line comment close', ->
      tokenizer.opensMultilineComment('  sdf # /**/').should.be.false
    it 'multi line comment close', ->
      tokenizer.opensMultilineComment('  test /**/').should.be.false
    it 'multi line comment inproper close', ->
      tokenizer.opensMultilineComment('  test /*/').should.be.true
    it 'multi line comment with single line comment', ->
      tokenizer.opensMultilineComment('  test /* # comment').should.be.true
    it 'multi line comment close then open', ->
      tokenizer.opensMultilineComment('  test /* comment */ more /*').should.be.true
    it 'weird cases', ->
      tokenizer.opensMultilineComment(' /**/#/*').should.be.false
    it 'single line in multi line', ->
      tokenizer.opensMultilineComment(' /*#*/').should.be.false
  describe 'getTokensInLine', ->
    describe 'class', ->
      it 'starting whitespace', ->
        tokenizer.getTokensInLine('   Tester').should.equal(['   ', 'Tester'])
      it 'trailing whitespace', ->
        tokenizer.getTokensInLine('   Tester    ').should.equal(['   ', 'Tester', '    '])
      it 'single line comments no space', ->
        tokenizer.getTokensInLine('Tester# test blah').should.equal(['Tester','# test blah'])
      it 'single line comments with space', ->
        tokenizer.getTokensInLine('Tester    # test blah').should.equal(['Tester','    ','# test blah'])
      it 'multi line comments with space no end', ->
        tokenizer.getTokensInLine('Tester    /* test blah').should.equal(['Tester','    ','/* test blah'])
      it 'multi line comments with space with end', ->
        tokenizer.getTokensInLine('Tester    /* test blah */  ').should.equal(['Tester','    ','/* test blah */', '  '])
      it 'multi line comments with space with end with single line', ->
        tokenizer.getTokensInLine('Tester    /* test blah */  # another comment').should.equal(['Tester','    ','/* test blah */', '  ', '# another comment'])
      it 'single line comment having multi line comments', ->
        tokenizer.getTokensInLine('Tester    #/* test blah */').should.equal(['Tester','    ','#/* test blah */'])
      it 'embedded comments', ->
        tokenizer.getTokensInLine('class/**/Tester').should.equal(['class', '/**/', 'Tester'])
    describe 'method', ->
      it 'a basic example', ->
        tokenizer.getTokensInLine('  main').should.equal(['  ', 'main'])
      it 'should separate classifiers', ->
        tokenizer.getTokensInLine('  +run').should.equal(['  ', '+', 'run'])
      it 'should separate multiple classifiers', ->
        tokenizer.getTokensInLine('  -&run').should.equal(['  ', '-', '&', 'run'])
      it 'params', ->
        tokenizer.getTokensInLine('  &alterPointer Rect r').should.equal(['  ', '&', 'alterPointer', ' ', 'Rect', ' ', 'r'])
      it 'return type', ->
        tokenizer.getTokensInLine('  &sumListEnhanced:int').should.equal(['  ', '&', 'sumListEnhanced', ':', 'int'])
      it 'return type with spaces', ->
        tokenizer.getTokensInLine('  &  sumListEnhanced     :    int').should.equal(['  ', '&', '  ', 'sumListEnhanced', '     ', ':', '    ', 'int'])
      it 'params and return type', ->
        tokenizer.getTokensInLine('  &sumListEnhanced int[] list :int').should.equal(['   ', '&', 'sumListEnhanced', ' ', 'int[]', ' ', 'list', ' ', ':', 'int'])
    describe 'assignment', ->
      it 'a basic example', ->
        tokenizer.getTokensInLine('    x = 3').should.equal(['    ', 'x', ' ', '=', ' ', '3'])
      it 'a basic example no spaces', ->
        tokenizer.getTokensInLine('    x=3').should.equal(['    ', 'x', '=', '3'])
      it 'comments on end', ->
        tokenizer.getTokensInLine('    x = 3#3').should.equal(['    ', 'x', ' ', '=', ' ', '3', '#3'])
      it 'comments on in middle', ->
        tokenizer.getTokensInLine('    /**/x/**/=/**/3').should.equal(['    ', '/**/', 'x', '/**/', '=', '/**/', '3'])
    describe 'string', ->
      it 'detect strings', ->
        tokenizer.getTokensInLine('    println "hi"').should.equal(['    ', 'println', ' ', '"hi"'])
      it 'detect strings with single quotes', ->
        tokenizer.getTokensInLine("    println 'hi'").should.equal(['    ', 'println', ' ', "'hi'"])
      it 'detect strings with special character quote marks', ->
        tokenizer.getTokensInLine('    println "h\"i"').should.equal(['    ', 'println', ' ', '"h\"i"'])
      it 'string interpolation', ->
        tokenizer.getTokensInLine('    println "In method alterPointer. r @r\n"').should.equal(['    ', 'println', ' ', '"In method alterPointer. r @r\n"'])
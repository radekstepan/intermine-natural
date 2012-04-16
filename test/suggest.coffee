should = require "should"
prolog = require "../prolog"

describe "testmodel.prolog suggest", ->
    
    describe 'suggest sentences', ->
        sentence = 'attr of company'
        expected = 'q([company (Class), name (Attribute)]) | q([company (Class), department (Reference)])'
        
        it 'should suggest matches', (done) ->
            prolog.suggest sentence, (output) ->
                [output].should.eql [expected]
                done()
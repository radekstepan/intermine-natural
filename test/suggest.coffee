should = require "should"
prolog = require "../prolog/prolog.coffee"

q =
    'against an unknown attribute':
        sentence: 'attr of company'
        path: 'q([company (Class), name (Attribute)]) | q([company (Class), department (Reference)])'
    'against an unknown class':
        sentence: 'salary of Radek'
        path: 'q([employee (Class), salary (Attribute)])'

describe "testmodel.prolog suggest", ->
    
    for test, {sentence, path} of q
        do (test, sentence, path) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output path, "' + path + '"', (done) ->
                    prolog.suggest sentence, (output) ->
                        [output].should.eql [path]
                        done()
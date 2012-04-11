should = require "should"
prolog = require "../prolog"

q =
    'against an attribute of an uknown class sentence':
        sentence: 'name of ACME'
        tree: 'company (Class) -> name (Attribute)'

describe "testmodel variables", ->
    
    for test, {sentence, tree} of q
        do (test, sentence, tree) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output parsed tree, "' + tree + '"', (done) ->
                    prolog.show_tree sentence, (output) ->
                        [output].should.eql [tree]
                        done()
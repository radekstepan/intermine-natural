should = require "should"
prolog = require "../prolog"

q =
    'when run against an attribute of a class sentence':
        sentence: 'name of company', tree: 'q(attribute(name),class(company))'
    'when run against a reference of a class sentence':
        sentence: 'CEO of company',  tree: 'q(reference(ceo),class(company))'

describe "testmodel.prolog", ->
    
    for test, {sentence, tree} of q
        do (test, sentence, tree) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output parsed tree, "' + tree + '"', (done) ->
                    prolog.show_tree sentence, (output) ->
                        [output].should.eql [tree]
                        done()
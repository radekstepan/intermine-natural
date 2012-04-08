should = require "should"
prolog = require "../prolog"

q =
    'against an attribute of a class sentence':
        sentence: 'name of company', tree: 'q(attribute(name),class(company))'
    'against a reference of a class sentence':
        sentence: 'CEO of company',  tree: 'q(reference(ceo),class(company))'
    'against an attribute of a class of a direct parent class sentence':
        sentence: 'name of CEO of company',  tree: 'q(attribute(name),class(ceo),class(company))'
    'against a reference of a class of a direct parent class sentence':
        sentence: 'computer of CEO of company',  tree: 'q(reference(computer),class(ceo),class(company))'
    'against an attribute of a class of a higher parent class sentence':
        sentence: 'processor of computer of company',  tree: 'q(attribute(processor),class(computer),class(company))'
    'against a reference of a class of a higher parent class sentence':
        sentence: 'monitor of computer of company',  tree: 'q(reference(monitor),class(computer),class(company))'

describe "testmodel.prolog", ->
    
    for test, {sentence, tree} of q
        do (test, sentence, tree) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output parsed tree, "' + tree + '"', (done) ->
                    prolog.show_tree sentence, (output) ->
                        [output].should.eql [tree]
                        done()
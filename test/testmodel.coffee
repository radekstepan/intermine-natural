should = require "should"
prolog = require "../prolog"

q =
    'when run against an attribute of a class sentence':
        s: 'name of company', t: 'q(attribute(name),class(company))'
    'when run against a reference of a class sentence':
        s: 'CEO of company',  t: 'q(reference(ceo),class(company))'

describe "testmodel.prolog", ->
    
    for test, c of q
        do (test, c) ->
            describe test + ' "' + c.s + '"', ->
                it 'should output parsed tree "' + c.t + '"', (done) ->
                    prolog.show_tree c.s, (tree) ->
                        [tree].should.eql [c.t]
                        done()
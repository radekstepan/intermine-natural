should = require "should"
prolog = require "../prolog"

describe "testmodel.prolog", ->
    describe "when run against attribute of a class sentence", ->
        sentence = "CEO of company"
        it "should output parsed tree", (done) ->
            prolog.show_tree sentence, (tree) ->
                [tree].should.eql ['q(reference(ceo),class(company))']
                done()
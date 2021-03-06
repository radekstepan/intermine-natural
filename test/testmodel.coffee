should = require "should"
prolog = require "../prolog/prolog.coffee"

q =
    'against an attribute of a class sentence':
        sentence: 'name of company'
        path: 'q([company (Class), name (Attribute)])'
    'against a reference of a class sentence':
        sentence: 'department of company'
        path: 'q([company (Class), department (Reference)])'
    'against an attribute of a class of a direct parent class sentence':
        sentence: 'name of department of company'
        path: 'q([company (Class), department (Class), name (Attribute)])'
    'against a reference of a class of a direct parent class sentence':
        sentence: 'employee of department of company'
        path: 'q([company (Class), department (Class), employee (Reference)])'
    'against an attribute of a class of an indirect parent class sentence':
        sentence: 'cpu of computer of company'
        path: 'q([company (Class), department (Class), employee (Class), computer (Class), cpu (Attribute)])'

describe "testmodel.prolog", ->
    
    for test, {sentence, path} of q
        do (test, sentence, path) ->
            describe test + ', "' + sentence + '"', ->
                it 'should output path, "' + path + '"', (done) ->
                    prolog.showPath sentence, (output) ->
                        [output].should.eql [path]
                        done()
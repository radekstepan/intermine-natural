#!/usr/bin/env coffee

exec = require('child_process').exec
fs   = require 'fs'

# Show a path for an input `sentence` if is valid according to Prolog rules.
exports.showPath = (sentence, callback) ->
    sentence = toProlog sentence
    callProlog("show_path([#{sentence}])", callback)

# Failing to match a path, variablize the sentence and get path suggestions.
exports.suggest = (sentence, callback) ->
    sentence = toProlog sentence
    
    index = 0
    (has_match = (output) ->
        if output or index is sentence.split(',').length
            callback output
        else
            ((index) ->
                vars = ("X#{i+1}" for i in [0..index-1]).join(',') if index
                callProlog("show_path([#{sentence}], [#{vars or ''}])", has_match)
            )(index++)
    )()

# Translate JSON representation of a model into Prolog rules.
exports.writeModel = (classes) ->
    out = []
    # Traverse all class definitions.
    for clazz, fields of classes
        # The Class definitions.
        clazz = clazz.toLowerCase()
        out.push "c(#{clazz}, '#{clazz} (Class)') --> [#{clazz}]."
        # Attributes?
        if fields.attributes?
            for attr, _ of fields.attributes
                attr = attr.toLowerCase()
                out.push "a(#{clazz}, '#{attr} (Attribute)') --> [#{attr}]."
        # References?
        if fields.references?
            for ref, _ of fields.references
                ref = ref.toLowerCase()
                out.push "r(#{clazz}, '#{ref} (Reference)') --> [#{ref}]."
        # Collections?
        if fields.collections?
            for coll, _ of fields.collections
                coll = coll.toLowerCase()
                out.push "r(#{clazz}, '#{coll} (Reference)') --> [#{coll}]."

    fs.open "./prolog/model.pro", 'w', 0o0666, (err, id) ->
        throw err if err
        fs.write id, out.join("\n"), null, "utf8"

# Call the, uh, Prolog.
callProlog = (predicate, callback) ->
    child = exec("prolog -f ./prolog/resolve.pro -g \"#{predicate},halt\"", (error, stdout, stderr) ->
        if not error then callback fromProlog stdout
    )

# Parse 'messy' sentence into Prolog form.
toProlog = (sentence) ->
    sentence.replace(/^\s|\s{2}/g, '').toLowerCase().split(' ').join(',')

# Cleanup Prolog output.
fromProlog = (output) ->
    output
    .replace(/\[\]\s*,\s*/g, '')  # strip empty lists
    .replace(/^\s+|\s+$/g, '')   # trim whitespace
    .replace(/\n|\nq/g, ' | ')   # split into different matches
    .replace(/\,\b(?! )/g, ', ') # follow comma with a space if not already
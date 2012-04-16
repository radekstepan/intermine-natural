exec = require('child_process').exec

# Show a tree for an input `sentence` if is valid according to Prolog rules.
exports.show_path = (sentence, callback) ->
    sentence = to_prolog sentence
    child = exec("prolog -f testmodel.pro -g \"show_path([#{sentence}]),halt\"", (error, stdout, stderr) ->
        if not error then callback from_prolog stdout
    )

exports.suggest = (sentence, callback) ->
    sentence = to_prolog sentence
    child = exec("prolog -f testmodel.pro -g \"show_path([#{sentence}], [X]),halt\"", (error, stdout, stderr) ->
        if not error then callback cleanup stdout
    )

# Parse 'messy' sentence into Prolog form.
to_prolog = (sentence) ->
    sentence.replace(/^\s|\s{2}/g, '').toLowerCase().split(' ').join(',')

cleanup = (output) ->
    output
    .replace(/^\s+|\s+$/g, '') # trim whitespace
    .replace(/\n|\nq/g, ' | ') # split into different matches

# Strip Prolog output into 'normal' text.
from_prolog = (output) ->
    output
    .replace(/\s|\[|\]/g, '')
    .replace(/\|/g, ',')
    .replace(/,{2}/g, ',')
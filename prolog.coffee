exec = require('child_process').exec

# Show a tree for an input `sentence` if is valid according to Prolog rules.
exports.show_tree = (sentence, callback) ->
    sentence = to_prolog sentence
    child = exec("prolog -f testmodel.pro -g \"show_tree([#{sentence}]),halt\"", (error, stdout, stderr) ->
        if not error then callback from_prolog stdout
    )

exports.suggest = (sentence, callback) ->
    sentence = variablize to_prolog sentence
    child = exec("prolog -f testmodel.pro -g \"suggest([#{sentence}]),halt\"", (error, stdout, stderr) ->
        if not error then callback cleanup stdout
    )

# Generate sentence variants with terms replaced by variables.
variablize = (sentence, vars=1) ->
    sentence = sentence.split(',')
    result = []
    for index in [1..sentence.length]
        list = []
        if index isnt 1
            list = list.concat sentence[0..index - 2]
        list = list.concat ['X']
        list = list.concat sentence[index..]
        result.push '[' + list.join(',') + ']'
    result.join(',')

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
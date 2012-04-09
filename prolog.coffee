exec = require('child_process').exec

# Show a tree for an input `sentence` if is valid according to Prolog rules.
exports.show_tree = (sentence, callback) ->
    sentence = to_prolog sentence
    child = exec("prolog -f testmodel.prolog -g \"show_tree([#{sentence}]),halt\"", (error, stdout, stderr) ->
        if not error then callback from_prolog stdout
    )

# Parse 'messy' sentence into Prolog form.
to_prolog = (sentence) ->
    sentence.replace(/^\s|\s{2}/g, '').toLowerCase().split(' ').join(',')

# Strip Prolog output into 'normal' text.
from_prolog = (output) ->
    output
    .replace(/\s|\[|\]/g, '')
    .replace(/\|/g, ',')
    .replace(/,{2}/g, ',')
    .replace(/,/g, ' -> ')[2..-2]
    .replace(/\(/g, ' (')
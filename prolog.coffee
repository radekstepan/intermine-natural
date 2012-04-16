exec = require('child_process').exec

# Show a path for an input `sentence` if is valid according to Prolog rules.
exports.show_path = (sentence, callback) ->
    sentence = to_prolog sentence
    call_prolog("show_path([#{sentence}])", callback)

# Failing to match a path, variablize the sentence and get path suggestions.
exports.suggest = (sentence, callback) ->
    sentence = to_prolog sentence
    
    index = 0
    (has_match = (output) ->
        if output or index is sentence.split(',').length
            callback output
        else
            ((index) ->
                vars = ("X#{i+1}" for i in [0..index-1]).join(',') if index
                call_prolog("show_path([#{sentence}], [#{vars or ''}])", has_match)
            )(index++)
    )()

# Call the, uh, Prolog.
call_prolog = (predicate, callback) ->
    child = exec("prolog -f testmodel.pro -g \"#{predicate},halt\"", (error, stdout, stderr) ->
        if not error then callback from_prolog stdout
    )

# Parse 'messy' sentence into Prolog form.
to_prolog = (sentence) ->
    sentence.replace(/^\s|\s{2}/g, '').toLowerCase().split(' ').join(',')

# Cleanup Prolog output.
from_prolog = (output) ->
    output
    .replace(/\[\]\s*,\s*/, '') # strip empty lists
    .replace(/^\s+|\s+$/g, '') # trim whitespace
    .replace(/\n|\nq/g, ' | ') # split into different matches
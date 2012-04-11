#!/bin/sh

git filter-branch --env-filter '

an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"

if [ "$GIT_COMMITTER_EMAIL" = "radek@core.(none)" ]
then
    cn="Radek"
    cm="dev@radekstepan.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "radek@core.(none)" ]
then
    an="Radek"
    am="dev@radekstepan.com"
fi

export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'
#/bin/bash

# call emacsclient with temporary file, then delete it.
TEMPFILE=$(mktemp)

# should find emacsclient for current implementation
emacsclient -c $TEMPFILE

rm -f $TEMPFILE

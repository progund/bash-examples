#!/bin/bash
DEBUG=true

debug(){
    $DEBUG && echo "$1"
}

debug "Here's a message..."
DEBUG=false
debug "Whatabout this?"

$DEBUG && echo "This will print if DEBUG is true"
DEBUG=true
$DEBUG && echo "This will print if DEBUG is true"

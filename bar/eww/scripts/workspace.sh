#!/bin/sh

# niri msg [-j] event-stream | grep '...'


case $1 in
  current)
    niri msg event-stream 
    ;;
  used)
    niri msg event-stream | grep 'Window changed:'
    ;;
  *)
    echo "Invalid argument"
    exit 1
    ;;
esac
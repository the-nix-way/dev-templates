#!/bin/bash

for dir in `ls -d */`; do # Iterate through all the templates
  (
    cd $dir
    nix flake update # Update flake.lock
    direnv reload    # Make sure things work after the update
  )
done

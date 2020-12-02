#!/usr/bin/env bash

set -u
EXIT_CODE=0

echo "========================================="
echo "pylint output:"
echo "========================================="
echo EXIT_CODE=$EXIT_CODE
pylint $PYLINTOPTS --jobs=0 $PYLINTFILES  || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE PYLINTOPTS=$EXIT_CODE

echo
echo "========================================="
echo "nosetests -a '!requires_sudo' output:"
echo "========================================="
nosetests -a '!requires_sudo' tests $NOSEOPTS  || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE nosetests=$EXIT_CODE

echo
echo "========================================="
echo "nosetests -a 'requires_sudo' output:"
echo "========================================="
sudo env "PATH=$PATH" nosetests -a 'requires_sudo' tests $NOSEOPTS  || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE sudonosetests=$EXIT_CODE

exit "$EXIT_CODE"
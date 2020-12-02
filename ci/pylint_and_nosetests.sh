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
echo "nosetests output:"
echo "========================================="
nosetests tests $NOSEOPTS  || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE nosetests=$EXIT_CODE


exit "$EXIT_CODE"
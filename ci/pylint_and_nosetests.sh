#!/usr/bin/env bash

set -u

pylint $PYLINTOPTS --jobs=0 $PYLINTFILES &> pylint.output & PYLINT_PID=$!

EXIT_CODE=0

echo "========================================="
echo "nosetests -a '!requires_sudo' output"
echo "========================================="
nosetests -a '!requires_sudo' tests $NOSEOPTS || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE nosetests = $?


echo "========================================="
echo "nosetests -a 'requires_sudo' output"
echo "========================================="
sudo env "PATH=$PATH" nosetests -a 'requires_sudo' tests $NOSEOPTS || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE sudo nosetest = $?

echo "========================================="
echo "pylint output:"
echo "========================================="
wait $PYLINT_PID || EXIT_CODE=$(($EXIT_CODE || $?))
pylint $PYLINTOPTS --jobs=0 $PYLINTFILES  || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE pylint =  $?

echo Final EXIT_CODE = $EXIT_CODE
exit "$EXIT_CODE"
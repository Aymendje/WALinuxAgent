#!/usr/bin/env bash

set -u

pylint $PYLINTOPTS --jobs=0 $PYLINTFILES &> pylint.output & PYLINT_PID=$!

EXIT_CODE=0

echo "========================================="
echo "nosetests -a '!requires_sudo' output"
echo "========================================="
nosetests -a '!requires_sudo' tests $NOSEOPTS || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE nosetests = $EXIT_CODE
sudo mv .coverage coverage.$RANDOM.no_requires_sudo.data

echo "========================================="
echo "nosetests -a 'requires_sudo' output"
echo "========================================="
sudo env "PATH=$PATH" nosetests -a 'requires_sudo' tests $NOSEOPTS || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE sudo nosetest = $EXIT_CODE
sudo mv .coverage coverage.$RANDOM.requires_sudo.data

wait $PYLINT_PID || EXIT_CODE=$(($EXIT_CODE || $?))
echo "========================================="
echo "pylint output:"
echo "========================================="
cat pylint.output
rm pylint.output
echo EXIT_CODE pylint = $EXIT_CODE

echo Final EXIT_CODE = $EXIT_CODE
exit "$EXIT_CODE"

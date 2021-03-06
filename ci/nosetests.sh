#!/usr/bin/env bash

set -u

EXIT_CODE=0

echo "========================================="
echo "nosetests -a '!requires_sudo' output"
echo "========================================="
sudo setpriv --reuid 65534 --regid 65534 --clear-groups nosetests -a '!requires_sudo' tests $(echo "${NOSEOPTS/__uuid__/$(uuidgen)}") || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE nosetests = $EXIT_CODE
mv .coverage coverage.$(uuidgen).no_requires_sudo.data

echo "========================================="
echo "nosetests -a 'requires_sudo' output"
echo "========================================="
nosetests -a 'requires_sudo' tests $(echo "${NOSEOPTS/__uuid__/$(uuidgen)}") || EXIT_CODE=$(($EXIT_CODE || $?))
echo EXIT_CODE sudo nosetest = $EXIT_CODE
mv .coverage coverage.$(uuidgen).requires_sudo.data

echo Final EXIT_CODE = $EXIT_CODE
exit "$EXIT_CODE"

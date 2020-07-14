#!/bin/sh
echo "is netlify: $NETLIFY"
echo "in branch: $BRANCH"

if [ "$NETLIFY" != "true" ]
then
  echo "this script only runs in netlify, bye"
  exit 1
fi

if [ "$BRANCH" != "dev" ]
then
  yarn preview
else
  echo "this script only runs in dev branch, bye"
fi


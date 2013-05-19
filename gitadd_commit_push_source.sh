#!/bin/bash

echo "git add ."
git add .
echo "Plz input yourcommit message: "
read msg
echo "git commit"
git commit -m "$msg"
echo "git push origin source"
git push origin source

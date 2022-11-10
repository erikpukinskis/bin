#!/bin/bash

USAGE=$(cat <<-END
Usage:
  b             list all git branches, sorted by most recently edited
  b 3           switch to branch 3
  b clean 10+   delete all branches from 10 on
END
)

branches=( $(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads) )
currentBranch=( $(git rev-parse --abbrev-ref HEAD) )

if [ -z "$1" ]
then
  for ((i = 0; i <= ${#branches[@]} - 1; i++))
  do
    branch=${branches[i]}

    if [ "$branch" == "$currentBranch" ]
    then
      echo -e " * $i\t$branch"
    else
      echo -e "   $i\t$branch"
    fi
  done
  exit
fi

if [ "$1" == "clean" ]
then
  if ! [[ $2 =~ ^[0-9]+\+$ ]]
  then
    echo "$USAGE"
    exit 1
  fi

  arg=$2
  branchnum=${arg%?}

  for (( i = $branchnum; i <= ${#branches[@]} - 1; i++ ))
  do
    git branch -D ${branches[$i]}
  done
  exit
fi


if ! [[ $1 =~ ^[0-9]+$ ]]
then
   echo "$USAGE"
   exit 1
fi

branchnum=$1
git checkout ${branches[$branchnum]}
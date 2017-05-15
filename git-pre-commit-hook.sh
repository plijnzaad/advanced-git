#!/bin/sh

## simple example of pre-commit hook. Put this in
## $YOURWORKINGCOPY/.git/hooks/pre-commit

readfirst=./env.sh.example
if [ -f $readfirst ] ; then 
   source $readfirst
fi

## Perl:
for file in  $(find . -name '*.p[lm]' -print); do
    if perl -wc $file; then 
        :
    else
        status=$?
        echo "Problem with $file, exit code $status" >&2
        exit $status
    fi
done

## R (very simplistic! Better check e.g. http://r-pkgs.had.co.nz/tests.html
## and for packages, use R CMD check)
for file in  $(find . -name '*.R' -print); do
    if cat $file | R --vanilla > /dev/null ; then 
        :
    else
        status=$?
        echo "Problem with $file, exit code $status" >&2
        exit $status
    fi
done

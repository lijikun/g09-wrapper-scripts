#!/bin/bash
#
# Runs g09 and emails last ten lines of result when finished.
# Usage: g09run [input filename] [email] 

extension='.com$|.gjf$'

if which g09
then
    if [[ -f $1 ]]
    then
        if [[ $1 =~ $extension ]]
        then
            echo "Running: g09 $1...."
            outputfile=${1/${BASH_REMATCH[0]}/\.log}
            g09 $1
            if which mail
            then
                echo "Mailing output to $2...."
                tail $outputfile | mail $2 -s "G09 Job $1 Result"                       else
                echo "No mail program. Mailing skipped."
            fi
        else
            echo "Input must have extension of .com or .gjf."
            exit 2
        fi
    else
        echo "Input $1 does not exist."
        exit 1
    fi
else
    echo "G09 is not initialized."
    exit 255
fi



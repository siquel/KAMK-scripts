#!/bin/bash

# get week number
to=$(/bin/date +%V)

for (( i=1; i<=$to; i++)); do
    url=$(printf "http://www.kajaani.fi/sites/default/files/fox_vko_%d_linjasto_1_ja_2.pdf" $i)
    response=$(curl -s --head "$url" | head -n 1)
    # not found
    if [[ $response == *"404"* ]]; then
        continue
    fi 
   
    linecount=$(./dump.sh $url | wc -l)
    if [[ $linecount -ne 5 ]]; then
        echo "url test $url failed"
    fi
done

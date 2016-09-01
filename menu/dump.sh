#!/bin/bash

url="$1"

# if user didn't provide url, fetch it from kajaani.fi
if [[ -z "$url" ]]; then
    # get week number
    week=$(/bin/date +%V)
    # current weeks url
    url=$(printf "http://www.kajaani.fi/sites/default/files/fox_vko_%d_linjasto_1_ja_2.pdf" $week)
fi

curl -s "$url" -o /tmp/ruokaa.pdf

# dump pdf to txt
file=$(pdftotext /tmp/ruokaa.pdf -)
cutted=""

if [[ $file == *"lkiruoka"* ]]; then
    cutted=$(echo "$file" | sed -e '1,44d' | sed -e '78,$d'  )

    # offset where to cut
    x=12
    # n is chosen to start as 2 because we save the start line
    for n in {2..5}; do
       cutted=$(echo "$cutted" | sed -e "$n,$x d"); 
       # increment offset
       x=$((x+1));
    done
    # cut all shitty lines 
    cutted=$(echo "$cutted" | sed -e "6,8d;11,12d;15,20d;22,32d")
    cutted=$(echo "$cutted" | awk '{a[NR]=$0} END { print a[6],a[7],a[8],a[9],a[1],a[2],a[3],a[4],a[5],a[10],a[11]}' OFS="\n" )
else
    # cut 44 first lines (wednesday start on #45) 
    # cut to EOF at "Keskiviikko"
    cutted=$(echo "$file" | sed -e '1,44d' | sed -n '/Keskiviikko/q;p')

    # offset where to cut
    x=12
    # n is chosen to start as 2 because we save the start line
    # cut 6 times
    for n in {2..7}; do
       cutted=$(echo "$cutted" | sed -e "$n,$x d"); 
       # increment offset
       x=$((x+1));
    done

    # cut Tiistai and \n
    # move 4 bottom lines to top (monday and tuesday)
    cutted=$(echo "$cutted" | sed -e '9,10d' | sed -e '1,6{H;d}; ${p;x;s/^\n//}')
fi

len=$(echo "$cutted" | wc -l)
if [[ len -eq 10 ]]; then
    echo "$cutted" | paste -d ";" - -
elif [[ len -eq 11 ]]; then
    # join jalkiruoka so we can use paste
    echo "$cutted" | sed '8N;s/\n/;/' | paste -d ";" - -
else
    echo "invalid shit"
fi

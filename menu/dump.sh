#!/bin/bash

url="$1"

# if user didn't provide url, fetch it from kajaani.fi
if [[ -z "$url" ]]; then
    # fetch current weeks url
    url=$(curl -s http://www.kajaani.fi/fi/mamselli/opiskelijaravintoloiden-ruokalistat | grep -P "fox_vko_[0-9]{1,2}_linjasto_1_ja_2" | sed -r 's/.+?\"(http.+?pdf)\".+/\1/')
fi

curl "$url" -o /tmp/ruokaa.pdf

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
#    echo "$cutted"
    echo "$cutted"
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

    echo "$cutted"
fi

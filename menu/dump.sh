curl -s http://www.kajaani.fi/fi/mamselli/opiskelijaravintoloiden-ruokalistat | grep -P "fox_vko_[0-9]{1,2}_linjasto_1_ja_2" | sed -r 's/.+?\"(http.+?pdf)\".+/\1/' | xargs -I % curl % -s -o /tmp/ruokaa.pdf

# dump pdf to txt
file=$(pdftotext /tmp/ruokaa.pdf -)
# cut 44 first lines (wednesday start on #45) 
# cut to EOF at "Keskiviikko"
echo "$file" | sed -e '1,44d' | sed -n '/Keskiviikko/q;p' > /tmp/ruokaa.txt

perl parse.pl

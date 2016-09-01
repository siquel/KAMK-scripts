# Menu dumper 

Parses the pdf found on kajaani.fi and outputs it as comma separated values by day. 

## Usage
```sh
# fetch the current weeks menu
./dump.sh
# fetch specific weeks menu
./dump.sh [url] 
```
## Example
```sh
[dippi@siqubox menu]$ ./dump.sh http://www.kajaani.fi/sites/default/files/fox_vko_33_linjasto_1_ja_2.pdf
Makkarakastiketta;Silakkapihviä # monday
Hedelmäistä broilerkastiketta;Lihakeittoa #tuesday
Lasagnettea;Maksa-porkkanakastiketta #wednesday
Hernekeittoa;Kebabkiusausta;Jälkiruoka: Ohukaiset #thursday
Kalaa venäläiseen tapaan;Jauhelihapihviä #friday

```

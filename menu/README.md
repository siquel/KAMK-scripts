# Menu dumper 

* Downloads current week menu using curl from http://www.kajaani.fi/mamselli/opiskelijaravintoloiden-ruokalistat as pdf to /tmp/ruokaa.pdf
* Converts the pdf to text file 
* Uses sed to cut unnecessary data and saves it to /tmp/ruokaa.txt
* Invokes parse.pl which transforms it human readable and outputs to STDOUT

## Usage
```sh
./dump.sh
```

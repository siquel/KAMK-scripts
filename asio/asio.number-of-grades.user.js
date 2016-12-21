// ==UserScript==
// @name        avg shit
// @namespace   siquel.me
// @include     https://asio.kajak.fi/pls/asio/asio_os.os_suoritukset?lang=f
// @version     1
// @grant       none
// ==/UserScript==

var table = document.getElementsByTagName('table')[1];

var COURSE_NAME_IDX = 0;

var GRADE1_IDX = 4;
var GRADE2_IDX = GRADE1_IDX + 1;
var GRADE3_IDX = GRADE2_IDX + 2;

var grades = [];
for (var i = 0; i < 6; ++i) {
    grades[i] = [];
}

// idx = 1, skip the header
for (var idx = 1; idx < table.rows.length; ++idx) {
  var row = table.rows[idx];
  // skip
  if (row.getAttribute("class") === "bolded") continue;
  
  var columns = row.getElementsByTagName("td");
  
  if (columns[GRADE1_IDX].innerHTML !== "") {
    if (columns[GRADE1_IDX].innerHTML === "H")
      grades[0].push({
        "grade": "H",
        "credits": columns[GRADE1_IDX - 1].innerHTML,
        "name": columns[COURSE_NAME_IDX].innerHTML
      });
    else {
      grades[parseInt(columns[GRADE1_IDX].innerHTML)].push({
        "grade": columns[GRADE1_IDX].innerHTML,
        "credits": columns[GRADE1_IDX - 1].innerHTML,
        "name": columns[COURSE_NAME_IDX].innerHTML
      });
    }
  }
  
}

var text = document.createElement('h3');
text.innerHTML = "Arvosanojen lukumäärä";
table.parentNode.insertBefore(text, table.nextSibling);

var newTable = document.createElement('table');
text.parentNode.insertBefore(newTable, text.nextSibling);

var header = document.createElement('tr');

var h1 = document.createElement('th');
h1.innerHTML = "Arvosana";

var h2 = document.createElement('th');
h2.innerHTML = "Määrä";

header.appendChild(h1);
header.appendChild(h2);

newTable.appendChild(header);

for (var i = 0; i < grades.length; ++i) {
  var tr = document.createElement('tr');
  
  for (var j = 0; j < 2; ++j) {
    var td = document.createElement('td');
    
    if (j == 0) {
     if (i == 0) td.innerHTML = "H";
     else td.innerHTML = i;
    } else {
     td.innerHTML = grades[i].length;
    }
    
    tr.appendChild(td);
  }
  
  newTable.appendChild(tr);
}

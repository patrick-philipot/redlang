Red[ needs: 'view ]

db: load %myprog.db

quotes: func [ str [string!] /local before after ] [
	either find str #"^"" [
			before: #"^{"
			after: #"^}"
		][
			before: after: #"^""
		]
	rejoin[ before str after ]
]

txtdb: %myprog.txt

write/append txtdb ""
database: load txtdb

count: 0

foreach item db [
	count: count + 1
	print "-------------------------"
    print [ quotes item/1 ]
    save txtdb repend database [ item/1 item/2 item/3 item/4 ]

]

? count





















; old codes
bk1:  [
name: "hello"
what: "hello-world"
tags: "print"
from: "tradition"

backup: func [ /local str-time back-name ][
    ; build a backup name from date as-is and time without second
    str-time: replace/all form now/time ":" "h"
    str-time: copy/part str-time find/last str-time "h"
    back-name: rejoin [ now/date "-" str-time ]
    return to-file append back-name ".db"
]

print backup

blk: copy []
append blk compose [

	(name) (what) (tags) (from)

]

lines: read/lines %myprog.db
n: back tail lines
insert/only n compose [

	(to-string name) (to-string what) (to-string tags) (to-string from)

]

write/lines backup lines
]





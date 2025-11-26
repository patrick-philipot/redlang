Red[]

print "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

print system/version
print "options args:"
probe system/options/args
print "script args:"
probe system/script/args

print "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

fields: [ nom age ville ]

save-db: func [db file /local out][
    out: make string! 50 * length? db
    foreach record db [
        append out trim/lines mold record
        append out newline
    ]
    write file out
]

load-db: func [file][
    either exists? file [load/all file] [copy []]
]



new-record: func [db fields /local record][
    record: copy []
	foreach field fields [
		value: ask form reduce ["Enter" field "value: "]
		append record value
	]
]

print-db: func[db][
    foreach record db [
        print record
    ]
]

find-db: func [db field [word!] value /local result offset index][
    result: copy[]
    offset: find fields field
    either offset [index: index? offset][
        print ["ERROR:" field " does not exist"]
        halt
    ]
    foreach record db [
        if find pick record index value [
            append/only result record
        ]
    ]
    result
]

sort-db: func [db field [word!] /local result offset][
    offset: find fields field
    either offset [offset: index? offset][
        print ["ERROR:" field " does not exist"]
        halt
    ]
    db: copy db
    sort/compare db func [a b][
        if a/:offset = b/:offset [return 0]
        either a/:offset > b/:offset [-1][1]
    ]
    db
]

;; tests

if probe system/script/args = 'test [

db: load-db %test.r 

print ["***^/Trouver qui a 66 ans" newline]

result: find-db db 'age "66"

print-db result

print ["***^/Trouver qui habite lyon" newline]

result: find-db db 'ville "lyon"

print-db result

print ["***^/Trouver qui habite LYON" newline]

result: find-db db 'ville "LYON"

print-db result

print ["***^/Tout afficher" newline]

print-db db

print ["***^/Tout afficher après tri" newline]

result: sort-db db 'ville

print-db result

]



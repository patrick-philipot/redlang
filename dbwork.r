;; ; recherche pour basedb
;; ; la première ligne de la database contient le fields

;; ; extraction du fields
;; base: load/all %testdb.r
;; fields: to-block mold/only base/1

;; ; extraction des données
;; db: remove base

;; ;ou bien

;; db: skip base 1

; traitement des erreurs
err_no_exist: ": does not exist"
panic: func [err][ print ["ERROR" err] halt ]

; charger une base de données composée de fields + données
load-db: func [file /local base][
    either exists? file 
    [ load/all file ][panic rejoin [file err_no_exist]]
]

print-db: func[db][
    foreach record db [
        print record
    ]
]

save-db: func [db file /local out][
    out: make string! 50 * length? db
    ; fields part
    append out trim/lines mold fields
    append out newline
    ; records
    foreach record db [
        append out trim/lines mold record
        append out newline
    ]
    write file out
]


; recherche des enregistrements pour une valeur de champ

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

; tri de la base sur un champ donné

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

new-record: func [db fields /local record][
    record: copy []
	foreach field fields [
		value: ask form reduce ["Enter" field "value: "]
		append record value
	]
	append/only db record
]

; tests 

db+fields: load-db %newbase.r

; décomposer db+fields
fields: to-block mold/only db+fields/1
db: skip db+fields 1

print mold fields
print mold db


do [

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

print ["***^/Tout afficher après tri sur la ville" newline]

result: sort-db db 'ville

print-db result

]





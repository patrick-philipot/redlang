Red [title: "Card File"]

if not exists? %data.txt [
    database: [
        "paul" "paris" "11 22 33" "note from paul"
        "john" "york" "44 55 66" "note from john"
        "romeo" "turin" "77 88 99" "note from romeo"
        "anna" "madrid" "33 22 11" "note from anna"
    ]
    save %data.txt database
]

; simplified Alert and request

alert: func [ message [string!] ][
    blk: compose [
        title "alert"
        text (message) return
        button "OK" [ unview ]  
    ]
    view/flags layout blk [popup]
]

request: func [ message [string!] ][
    ret: false
    blk: compose [
        title "request"
        text (message) return
        button "Yes" [ ret: true unview ]   
        button "No" [ unview ]  
    ]
    view/flags layout blk [popup]
    ret
]

write/append %data.txt ""
database: load %data.txt

clear-button-clicked: function [][
        n/text: copy  ""
        a/text: copy  ""
        p/text: copy  ""
        o/text: copy  ""
        show gui
]

save-button-clicked: function [][
        if n/text = "" [alert "You must enter a name." return none]
        if find (extract database 4) n/text [
            either true = request "Overwrite existing record?" [
               remove/part (find database n/text) 4
            ] [
               return none
            ]
        ]
        save %data.txt repend database [n/text a/text p/text o/text]
        name-list/data: sort (extract copy database 4)
        show name-list
]

view gui: layout [
    title "card-file for Red"
    style btn: button 
    
    across
    text "Records list" return

    below
    name-list: text-list blue 100x300 data sort (extract database 4) [
        value: pick face/data face/selected
        if value <> none [
            marker: index? find database value
            n/text: pick database marker
            a/text: pick database (marker + 1)
            p/text: pick database (marker + 2)
            o/text: pick database (marker + 3)
            show gui
        ]
    ]

    return

    text "Name"       n: field 272
    text "Address"    a: field 272
    text "Phone"      p: field 272
    text "Notes"      o: area  272x100

    across

    btn "Save" [ save-button-clicked ]


    btn "Delete" [
        if true = request rejoin ["Delete " n/text "?"] [
            remove/part (find database n/text) 4
            save %data.txt database
            clear-button-clicked
            name-list/data: sort (extract copy database 4)
            show name-list
        ]
    ]

    clear-button: btn "New" [ clear-button-clicked ]
]
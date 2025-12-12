Red [
    title: "REBOL to Red"
    genre: "database"
    purpose: "Helping the conversion of REBOL code to Red"
    credit: "derived from the card-file example by Nick Antonaccio"
    
]

fields: [ "command" "compatibility" "reference"]
nb-fields: length? fields
data-file: %r2red.txt

if not exists? data-file [
    database: [
        "do-face" "undocumented for Rebol" "tbd"
        "style" "VID style is expecting a set-word for its first parameter" "tdb"
        "btn" "VID btn does not exist for Red" "replace it by button or define a style for it"
        "alert" "not available, use a popup" "tbd"
        "request" "not available, use a popup" "tbd"
    ]
    save data-file database
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

write/append data-file ""
database: load data-file

clear-button-clicked: function [][
        a/text: copy  ""
        b/text: copy  ""
        c/text: copy  ""
        show gui
]

save-button-clicked: function [][
        if a/text = "" [alert "You must enter a name." return none]
        if find (extract database nb-fields) a/text [
            either true = request "Overwrite existing record?" [
               remove/part (find database a/text) nb-fields
            ] [
               return none
            ]
        ]
        save data-file repend database [a/text b/text c/text]
        name-list/data: sort (extract copy database nb-fields)
        show name-list
]

img:  draw 24x24 [ 
    pen black fill-pen white box 5x7 15x22 
    polygon 15x4 8x4 8x19 19x19 19x8
    triangle 15x4 15x8 19x8
    line 11x11 16x11
    line 11x15 16x15
]

gui: layout [
    title "Commands compatibility between REBOL & Red"
    style btn: button 100
    
    across
    text "Commands" return

    below
    name-list: text-list blue 100x380 data sort (extract database nb-fields) [
        value: pick face/data face/selected
        if value <> none [
            marker: index? find database value
            a/text: pick database marker
            b/text: pick database (marker + 1)
            c/text: pick database (marker + 2)
            show gui
            set-focus name-list
        ]
    ]

    return

    do [ f1: fields/1 f2: fields/2 f3: fields/3 ]

    text f1  a: field 272
    text f2  panel [ across b: area 272x100  button 24x28 img [ write-clipboard b/text ] ]
    text f3  panel [ across c: area 272x100  button 24x28 img [ write-clipboard c/text ] ]     
    
    across

    btn "Save" [ save-button-clicked ]


    btn "Delete" [
        if true = request rejoin ["Delete " a/text "?"] [
            remove/part (find database a/text) nb-fields
            save data-file database
            clear-button-clicked
            name-list/data: sort (extract copy database nb-fields)
            show name-list
        ]
    ]

    clear-button: btn "New" [ clear-button-clicked ]
]

view gui

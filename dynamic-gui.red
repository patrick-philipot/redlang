Red[ from: "http://re-bol.com/rebol.html#section-9.21"]

alert: func [ message [string!] ][
    blk: compose [
        title "alert"
        text (message) return
        button "OK" [ unview ]  
    ]
    view/flags layout blk [popup]
]

view center-face layout [
    style btn: button
    below
    text "Select a button width, in pixels:"
    d: drop-down data ["250" "400" "550"]
    text "Enter any number of button labels (text separated by spaces):"
    f: field 475
    btn "Generate GUI" [
        created-buttons: copy compose/deep [
            style new-btn: button (to-integer d/text) [
                alert rejoin ["This button's label is: " face/text ]
            ]
            below
        ]       
        foreach item to-block f/text [
            append created-buttons compose [
                new-btn (form item)
            ]
        ]
        view center-face layout created-buttons
    ]
]
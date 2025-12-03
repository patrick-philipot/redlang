view [
    title "ex14.red building styles"
    style my-button: base 100x24 extra context [
        redraw: func [face][
            face/draw: compose [
                line-width 4
                pen black
                fill-pen white
                box 0x0 (face/size)
                pen black
                text 16x16 (face/text)
            ]
        ]
    ] on-create [
        face/extra: make face/extra []
        face/extra/redraw face
    ] on-over [
        face/draw/4: either event/away? [black][255.180.180]
    ] on-down [
        face/draw/6: 180.255.255
    ] on-up [
        face/draw/6: white
    ]

    text "ref : https://red.qyz.cz/writing-style.html"

    below

    my-button "Hello"
    my-button 200x50 "world"

]

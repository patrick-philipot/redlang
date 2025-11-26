Red[needs: 'view]

win: layout [
    size 400x500
    across
    style ball: base 30x30 transparent draw [fill-pen blue circle 15x15 14]
    ball ball ball ball ball ball ball b: ball loose
    do [b/draw/2: red]
]

follow: func [left right][left/offset/y: to integer! right/offset/y * 108%]

faces: win/pane
while [not tail? next faces][
    react/link :follow [faces/1 faces/2]
    faces: next faces
]
view win
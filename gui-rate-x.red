Red [
    what: {gui animation with rate}
    tag: {rate draw focus set-focus pen circle with on-key }
    from: {http://rebol.net/cookbook/recipes/0047.html}
]
pos: 0x0
size: 0
inc: 1
dir: 2

do-update: does [
    blk-circles: compose [
        pen red
        circle (100x200 + pos) (50 - size)
        circle (200x200 + pos) (50 + size)
        circle (300x200 + pos) (50 - size)
    ]
]

do-update

view layout [
    title { Draw animation with rate and on-key}
    b: box black 400x400 white "Use cursor keys for up or down" with [draw: blk-circles]
        rate 30 on-time [
        size: size + inc
        pos/y: pos/y - dir
        if size < -49 [inc: 1]
        if size > 49 [inc: -1]
        if pos/y < -200 [dir: -2]
        if pos/y > 199 [dir: 2]
        b/draw: do-update
    ] on-key [
        switch event/key [
            up [dir: 2]
            down [dir: -2]
            b/draw: do-update
        ]
    ] focus
    ; do [set-focus b] ; Needed for key events to be recognised.
]

        
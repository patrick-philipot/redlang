Red [
    what: {gui animation with rate}
    tag: {rate draw}
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
    b: box black 400x400 white "draw animation with rate" with [draw: blk-circles]
        rate 30 on-time [
        size: size + inc
        pos/y: pos/y - dir
        if size < -49 [inc: 1]
        if size > 49 [inc: -1]
        if pos/y < -200 [dir: -2]
        if pos/y > 199 [dir: 2]
        b/draw: do-update
    ]
]

        
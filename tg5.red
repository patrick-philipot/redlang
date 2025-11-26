Red[ purpose: { tile-game with valid moves only } ]

; spacing between tiles and tile size
margin: 2X2
tile-size: 80
tiles-by-row: 4
nb-tiles: 16
root: %./tiles/OBIWAN/

; building the view layout block
lay-blk: copy []

append lay-blk compose [ 
    title "Tile-Game for Red"
    style t: box red [
        x: face/offset
        s: x - e/offset
        ; valid move ?
        unless (absolute s/1) + (absolute s/2) - margin/1 <> tile-size [
            face/offset: e/offset 
            e/offset: x
        ]
    ] 
    across 
    origin margin
    space margin
]

; t "9"  %./tiles/vader/tile8.png

repeat i (nb-tiles - 1) [
    j: nb-tiles - i
    append lay-blk compose [ 
        t ( to-string j ) 
    ]  
    file: rejoin [ root  rejoin ["tile" j] %.png ]
    append lay-blk compose [ 
        (file)  
    ]
    if 0 == mod i tiles-by-row [ append lay-blk [ return ]]
]

append lay-blk [ 
    e: box
]

probe lay-blk

view layout lay-blk
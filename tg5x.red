Red[ purpose: { tile-game with valid moves only } ]

; spacing between tiles and tile size
margin: 2X2
tile-size: 80
tiles-by-row: 4
nb-tiles: 16
root: %./tiles/EXTRA/

; collecting the tiles
; popups

pop-open: func [blk [block!]][view/flags layout  blk [ popup ]]

pop-dir: [
    title "Select the tiles folder"
    below
    h2 "Tile-Game "
    text {Chargement des tuiles : utilisez le bouton "OK" pour désigner le répertoire contenant^/les tuiles. Ce répertoire doit contenir 9 ou 16 tuiles selon la taille de  l'image à reconstituer.^/Il ne doit contenir que les tuiles d'une seule image!
    }

    text bold {Pressez OK pour ouvrir le sélecteur de dossier, ou ^/Stop pour quitter.}
    
    across
    button "OK" [ unview ]  
    button "Stop" [ stopped: true unview ]
]

; asking for image and directory

stopped: false

pop-open pop-dir

unless stopped [
    ; 
    tiles-dir: request-dir/title "Select the tiles directory" 
    either exists? rejoin [ tiles-dir %tile16.png ] [
        tiles-by-row: 4
        nb-tiles: 16
    ][
        either exists? rejoin [ tiles-dir %tile9.png ][
            tiles-by-row: 3
            nb-tiles: 9
        ][
            print "No tile found"
            print "Process stopped"
            halt
        ]
    ]
]

if stopped [ print "Process stopped by user" halt ]

root: tiles-dir

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
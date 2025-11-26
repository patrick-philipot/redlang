Red[ purpose: { tile-game with valid moves only } ]

; spacing between tiles and tile size
margin: 2X2
tile-size: 80

view layout [ 
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

    t "8"  %./tiles/vader/tile8.png
    t "7"  %./tiles/vader/tile7.png
    t "6"  %./tiles/vader/tile6.png return 
    t "5"  %./tiles/vader/tile5.png
    t "4"  %./tiles/vader/tile4.png
    t "3"  %./tiles/vader/tile3.png return 
    t "2"  %./tiles/vader/tile2.png
    t" 1"  %./tiles/vader/tile1.png

    e: box 
]
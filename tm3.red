Red [ purpose: "tile-maker" ]


; popups

pop-open: func [blk [block!]][view/flags layout blk [popup]]

pop-img: [
	title "Select an image-source for the tiles"
	text " Pressez OK pour ouvrir le sélecteur d'image" return
	button "OK" [ unview ]	
]

pop-dir: [
	title "Select a folder to store the tiles"
	text " Pressez OK pour ouvrir le sélecteur de répertoire" return
	button "OK" [ unview ]	
]

pop-open pop-img

img: load img-file: request-file/title "Select a 240x240 or 320x320 png file"

pop-open pop-dir

tiles-dir: request-dir/title "Select a directory for saving the tiles"

; check size 
either any [img/size == 240x240 img/size == 320x320] [	
	print "processing ..." 
	nb-tiles: img/size/1 / 80
][
	print "Wrong image size ! Must be either 240x240 or 320x320 pixels"
	halt
]

; building tiles
i: 1
repeat row nb-tiles [
	top: 0x0 + (row - 1) * 0x80
	bot: top + 80x80
	repeat col nb-tiles [
		img-name: rejoin ["tile" i]
		i: i + 1
		set to-set-word img-name draw  80x80 reduce ['image img 'crop top bot]
		; save/as rejoin [to-file img-name %.png] get to-word img-name 'png
		tile-file: rejoin [ tiles-dir img-name %.png ]
		save/as to-file tile-file get to-word img-name 'png
		; increment for next col
		top:  top + 80x0
		bot:  top + 80x80
	]
]

; spacing between tiles
margin: 2x2 

; building the view layout block
lay-blk: copy []
append lay-blk compose [
	origin margin
    space margin

	image (img/size) img return
]
repeat i (nb-tiles * nb-tiles) [
	append lay-blk compose [
		image (to-word rejoin ["tile" i])
	]
	if 0 == mod i nb-tiles [ append lay-blk [ return ]]
]

probe lay-blk

view layout/tight/options lay-blk [offset: 900x500]
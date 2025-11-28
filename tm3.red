Red [ purpose: "tile-maker" ]


; popups

pop-open: func [blk [block!]][view/flags layout  blk [ popup ]]

pop-img: [
	title "Select an image-source for the tiles"
	below
	h2 "Tile-maker (1/2)"

	text {Première étape : sélection de l'image à découper en tuiles carrées.^/Cette image doit respecter les conditions suivantes : ^/- format PNG^/- taille 240x240 ou 320x320
	}

	text bold {Pressez OK pour ouvrir le sélecteur d'image, ou ^/Stop pour quitter.}
	
	across
	button "OK" [ unview ]	
	button "Stop" [ stopped: true unview ]
]

pop-dir: [
	title "Select a folder to store the tiles"
	below
	h2 "Tile-maker (2/2)"
	text {Seconde étape : sélection du répertoire où seront déposées les tuiles.^/Il est conseillé, mais pas obligatoire, de regrouper dans un même dossier dédié, ^/à la fois l'image d'origine et les tuiles.
	}
	text bold {Pressez OK pour ouvrir le sélecteur de dossier, ou ^/Stop pour quitter.}
	
	across
	button "OK" [ unview ]	
	button "Stop" [ stopped: true unview ]
]

; asking for image and directory

stopped: false

pop-open pop-img

unless stopped [
	img: load img-file: request-file/title "Select a 240x240 or 320x320 png file"
	pop-open pop-dir
]

if stopped [ print "Process stopped by user" halt ]

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
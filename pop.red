Red [ 
	purpose: "popup-test" 
	tags: [ popup modal layout view unless ]
]

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

probe blk

unless stopped [
	pop-open pop-dir
]

if stopped [ print "Process stopped by user" halt ]

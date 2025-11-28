Red [ 
	purpose: "popup-test" 
	tags: [ popup modal layout view unless ]
]

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

print "success"
? tiles-dir
? tiles-by-row
? nb-tiles






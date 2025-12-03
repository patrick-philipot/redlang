Red [needs 'view]

popup-text: {
text "-------------------------------------------------"
return
button "test" [print "clicked"]
return}

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

run-code-x: func [blk [block!]][
	xview: view/flags layout blk [popup]
	probe xview
]

alert: func [ message [string!] ][
	blk: compose [
		title "alert"
		text (message) return
		button "OK" [ unview ]	
	]
	view/flags layout blk [popup]
]

request: func [ message [string!] ][
	ret: false
	blk: compose [
		title "request"
		text (message) return
		button "Yes" [ ret: true unview ]	
		button "No" [ unview ]	
	]
	view/flags layout blk [popup]
	ret
]


alert "Ceci est une alerte"
print request "Must return true"
print request "Must return false"

















old: [
	title "Étude fenêtre PopUp modale ou non"
	size 400x400
	source: area 380 popup-text return

	button "Open Modal Popup" [
		print "Modal+PopUp"
		xcode: load/all source/text
		view/flags layout xcode [modal popup]
	] 

	button "Select Image" [ 
		pop-open pop-img
	]	

	button "Select Dir" [ 
		pop-open pop-dir
	]

	return

	button "Open PopUp Ex." [ 
		blk-code: load/all source/text run-code-x blk-code 
	]

	button "Tile-maker 1" [ 
		run-code popup-blk 
	]

]



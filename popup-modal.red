Red [needs 'view]

popup-text: {
text "-------------------------------------------------"
return
button "test" [print "clicked"]
return}

run-code-x: func [blk [block!]][
	xview: view/flags layout blk [popup]
	probe xview
]

run-code: func [blk [block!]][view/flags layout blk [popup]]

view [
	title "Étude fenêtre PopUp modale ou non"
	size 400x400
	source: area 380 popup-text return

	button "Open Modal Popup" [
		print "Modal+PopUp"
		xcode: load/all source/text
		view/flags layout xcode [modal popup]
	] 

	button "Open PopUp" [ 
		print "PopUp"
		blk-code: load/all source/text run-code blk-code 
	]

	return

	button "Open PopUp Ex." [ 
		blk-code: load/all source/text run-code-x blk-code 
	]

	button "xview?" [probe xview]

	button "unview/only xview" [ unview/only xview ]
]



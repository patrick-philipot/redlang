Red [ about: "on-down with image" ]


square: draw 50x50 [ pen red fill-pen red box 0x0 50x50]


; only base reacts to mouse left click
view layout [
	style img: base 100x100


	text "click the red square (no effect)"
	a: image square on-down [ print "image on-down"] 

	b: base on-down [ print "base on-down"]

	c: img on-down [ print "img on-down"]

	return

	button "click to print informations" [
		print "image actors ..."
		probe a/actors 
		print "base actors ..."
		probe b/actors
		print "img actors ..."
		probe c/actors
		?? system/view/vid/styles/image
	]
]
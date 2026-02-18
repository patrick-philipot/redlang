Red[ 
	what: "crop with draw"
	from: "gitter/Oldes"
]

img: draw 300x300 [ pen red fill-pen blue circle 150x150 75 pen red fill-pen green box 100x100 250x150 ]
img2: copy/part at img 101x101 150x50

view layout [ image img return image img2 ]

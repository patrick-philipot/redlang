Red[ purpose: { making icon write draw, sending text to the clipboard}]

img:  draw 24x24 [ 
	pen black fill-pen white box 5x7 15x22 
	polygon 15x4 8x4 8x19 19x19 19x8
	triangle 15x4 15x8 19x8
	line 11x11 16x11
	line 11x15 16x15
]

view layout [
	title "Copy to clipboard icon made with draw"
	below
	t: text transparent red bold "Text to be sent to the clipboard" 
	across
	button 24x28 img [ write-clipboard t/text ]
	text "clic this icon to send the red text to the clipboard"

]


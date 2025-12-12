Red[ purpose: { making icon write draw, sending text to the clipboard}]

move-draw: func [ "return a new draw block moved N pixel up" 
				blk [block!] move [pair!] /local new-blk ][
	new-blk: copy []
	foreach item blk [
		if pair! = type? item [ item: item + move ]
		append new-blk item
	]
	return new-blk
]

dblk: [ 
	line-width 1
	pen black fill-pen white box 5x7 15x23
	polygon 15x5 8x5 8x20 19x20 19x8
	line 14x5 14x10
	line 14x10 19x10
	line 11x12 17x12
	line 11x16 17x16
]


img:  draw 22x22 move-draw dblk 0x-3


view layout [
	title "Copy to clipboard icon made with draw"
	below
	t: text transparent red bold "Text to be sent to the clipboard" 
	across
	button 24x26 img [ write-clipboard t/text ]
	text "clic this icon to send the red text to the clipboard" return
]


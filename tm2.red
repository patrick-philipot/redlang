Red [ purpose: "tile-maker" ]

img: load img-file: request-file/title "Select a 240x240 png file"

tiles-dir: first split-path img-file

dir-name: ask "Please enter a directory name for saving the tiles^/" 

?? tiles-dir

append tiles-dir dir-name

?? tiles-dir


; check size 
either any [img/size == 240x240 img/size == 320x320] [	
	print "processing ..." 
	nb-tiles: img/size/1 / 80
][
	print "Wrong image size ! Must be 240x240 pixels"
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
		save/as rejoin [to-file img-name %.png] get to-word img-name 'png
		; save/as rejoin [to-file file %.png] reduce file 'png
		; next col
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
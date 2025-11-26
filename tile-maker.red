Red [ purpose: "tile-maker" ]

img: load request-file/title "Select a 240x240 png file"

; check size 
either img/size == 240x240 [	
	print "processing ..." 
][
	print "Wrong image size ! Must be 240x240 pixels"
	halt
]

; [0x0 80x0 160x0 0x80 80x80 160x80 0x160 80x160 160x160]
blk: copy []

i: 1

repeat row 3 [
	top: pick [0x0 0x80 0x160] row
	bot: top + 80x80
	repeat col 3 [
		img-name: rejoin ["tile" i]
		i: i + 1
		set to-set-word img-name draw  80x80 reduce ['image img 'crop top bot]
		save/as rejoin [to-file img-name %.png] get to-word img-name 'png
		; save/as rejoin [to-file file %.png] reduce file 'png
		append blk top
		; next col
		top:  top + 80x0
		bot:  top + 80x80
	]
]

;probe blk

; spacing between tiles
margin: 2x2 

view layout/tight/options [
    origin margin
    space margin

	image 240x240 img return
	image tile1
	image tile2
	image tile3 return
	image tile4
	image tile5
	image tile6 return
	image tile7
	image tile8
	image tile9

][offset: 900x500]
Red [needs: 'view 
	title: "take syntax"
	what: "Visualize the TAKE command syntax"
	from: {Red Beginners Reference Guide by Alan Brack: Here we use: 'take' 'take/last' }

	; first value?
	;USAGE:
	;    TAKE series
	;
	;DESCRIPTION: 
	;     Removes and returns one or more elements. 
	;     TAKE is an action! value.
	;
	;ARGUMENTS:
	;     series       [series! port! none!] 
	;
	;REFINEMENTS:
	;     /part        => Specifies a length or end position.
	;        length       [number! series!] 
	;     /deep        => Copy nested values.
	;     /last        => Take it from the tail end.

]

t: copy [12 13 14 15 16 17]
td: mold t

reset: does [
	taken1/text: ""
	taken2/text: ""
	taken3/text: ""
]

view/options  layout [
	title "Using TAKE"

	style btn-set: button 400
	style btn: button 100
	style display: text 285 bold

	text bold "T >>>" 
	t-display: display td

	return

	btn "take t" [ 
			taken1/text: mold take t
			t-display/text: mold t
			]

	taken1: display ""

	return

	btn "take/last t" [ 
			taken2/text: mold take/last t
			t-display/text: mold t
			]

	taken2: display ""

	return	

	btn "take/part t 3" [ 
			taken3/text: mold take/part t 3
			t-display/text: mold t
			]

	taken3: display ""

	return

	btn-set "reset T with block of integer" [
			reset
			t: copy [12 13 14 15 16 17]
			t-display/text: mold t
	]	

	return

	btn-set "reset T with string" [
			reset
			t: copy "ABCDEFG"
			t-display/text: mold t
	]

	return

	btn-set "reset T with block of words" [
			reset
			t: copy [ 'one 'two 'three 'four 'five 'six ]
			t-display/text: mold t
	]

	return

	btn-set "reset T with block of blocks" [
			reset
			t: copy [ "new" [1 2] %file1.txt ["one" [%file2.txt]]]
			t-display/text: mold t
	]



][offset: 900x560 ]
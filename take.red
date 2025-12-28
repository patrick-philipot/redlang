Red [needs: 'view title: "fonts"]

t: copy [12 13 14 15 16 17]
td: mold t

view/options  layout [
	title "Using TAKE"

	text bold "T >>>" 
	t-display: text bold td

	return

	Button 100 "take t" [ 
			taken1/text: mold take t
			td: mold t
			t-display/text: td
			]

	taken1: text bold ""

	return

	Button 100 "take/last t" [ 
			taken2/text: mold take/last t
			td: mold t
			t-display/text: td
			]

	taken2: text bold ""

	return	

	Button 100 "take/part t 3" [ 
			taken3/text: mold take/part t 3
			td: mold t
			t-display/text: td
			]

	taken3: text bold ""

	return

	button 200 "reset T" [
			td: mold t: copy [12 13 14 15 16 17]
			t-display/text: td

	]



][offset: 900x560 ]
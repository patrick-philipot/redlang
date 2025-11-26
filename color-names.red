Red [needs 'view]

colors: [
	red transparent white gray aqua beige black 
	blue brick brown coal coffee crimson 
	cyan forest gold green ivory khaki 
	leaf linen magenta maroon mint navy 
	oldrab olive orange papaya pewter pink 
	purple reblue rebolor sienna silver sky 
	snow tanned teal violet water wheat 
	yello yellow glass ]

new-color: func [ col [tuple!]][
	av: ( col/1 + col/2 + col/3 ) / 3
	either av > 127 [return black][return white]
]

out: { title "Red Color-names"
	style btn1: text font-size 11 font-color black 100x38 [sc/color: face/color sc/text: form face/color sc/font/color: black]
	style btn2: text font-size 11 font-color white 100x38 [sc/color: face/color sc/text: form face/color sc/font/color: white] 
	; special case for transparent and glass
	style btn3: text font-size 11 font-color black 100x38 [sc/color: black sc/text: "0.0.0.255" sc/font/color: white] }

cp: 1
foreach color colors [
	; special case for glass and transparent
	either any [color = 'glass color = 'transparent] 
		; special case
		[ append out form reduce [ {btn3} color #" "]]
		; other cases
		[
		either (new-color reduce color) = black [ append out form reduce [ {btn1} color #" "]]
												[ append out form reduce [ {btn2} color #" "]]
		]
	append out mold form reduce [color newline get color]
	append out newline 
	if zero? cp // 6 [append out " return^/"]
	cp: cp + 1
]

append out {return sc: box 650x40 pink font-size 16 font [color: 255.0.0] "255.164.200"}

print out

win: layout to-block out 

view win

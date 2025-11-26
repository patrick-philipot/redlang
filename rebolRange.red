Red[
	purpose: {from http://blog.revolucent.net/2009/04/dirt-simple-dsl-in-rebol.html}
	about: {a DSL to do list comprehensions}
]


range: func [ {Return a block of sequential values from a pair or a two numbers block}
	pair [pair! block!] /local min max result][ 
	min: first pair
	max: second pair
	result: copy []
	for n min max either min < max [1] [-1] 
		[ append result n
	]
	result 
]

; Examples
do [

probe range 10x20 	;== [ 10 11 12 13 14 15 16 17 18 19 20 ]
probe range [20 10] ;== [ 20 19 18 17 16 15 14 13 12 11 10 ]

]
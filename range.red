; from simpleDSL
Red[]

range: func [pair [pair! block!] /local start-value end-value increment nb-iter ][ 
	start-value: first pair 
	end-value: second pair
	increment: either start-value < end-value [1][-1]
	nb-iter: absolute ( end-value - start-value )

	result: copy []
	append result start-value

	repeat i nb-iter [
		append result start-value + ( i * increment )
	]
	result 
]

do [

probe range 10x20
probe range 20x10
probe range [8 12]
probe range [12 8]
]

; EXPECTED
;>> range 10x30
;== [10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30]
;>> range 20x10
;== [20 19 18 17 16 15 14 13 12 11 10]
;>> range [8 12]
;== [8 9 10 11 12]

;range: func [pair [pair! block!] /local min max result][ 
;	min: first pair
;	max: second pair
;	result: copy []
;	for n min max either min < max [1] [-1] 
;		[ append result n
;	]
;	result 
;]
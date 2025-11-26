Red[purpose: {adapting the Simple DSL example to Red}
	from: {http://blog.revolucent.net/2009/04/dirt-simple-dsl-in-rebol.html}
]

; "Recreation of the REBOL for that repeats a block over a range of values." 
_for: func [
    'word [word!] "Variable to hold current value" 
    start [number!] "Starting value" 
    end [number!] "Ending value" 
    bump [number! ] "Amount to skip each time" 
    body [block!] "Block to evaluate" 
    /local indexes op ][

    ; preparing the indexes
    indexes: copy []

	either negative? bump [op: :lesser-or-equal?][op: :greater-or-equal?]

	while [ op end start ] [
		append indexes start
		start: start + bump
	]

	do-body: func reduce [word] body
	foreach i indexes [ do-body i ]

 ]

range: func [pair [pair! block!] /local min max result][ 
	min: first pair
	max: second pair
	result: copy []
	_for n min max either min < max [1] [-1] 
		[ append result n
	]
	result 
]

; main function

list: func [ 
	{Performs a list comprehension.} 
	comprehension [block!]
	/type datatype [datatype!] 
	/local args action elems filter index list result rules skip vars
	][
	vars: make object! [] 
	rules: [ set action [block!] ; block à exécuter
	some [
		'for set var word!
		'in set list [word! | series! | pair!]
		(if pair? list [list: range list])
		(vars: make vars reduce [to-set-word var either paren? list [do list] [list]]) 
		] ;some
		opt [ 'where set filter [block!]] 
	]

	unless parse comprehension rules [
		make error! "The list comprehension was not valid."
	]

	; building the action and filter function
	spec: copy []
	foreach field words-of vars [append spec field]
	action: func copy spec action
	filter: func copy spec either filter [filter] [[true]] 

	elems: 1
	foreach field words-of vars [
		result: copy []
		elems: elems * length? get field
	]

	_for n 0 (elems - 1) 1 [
		skip: elems
		args: copy []
		foreach field words-of vars [
			list: get field
			skip: skip / length? list
			index: (mod to-integer (n / skip) length? list) + 1 
			append args list/(index)
			]
		if do compose [filter (args)] [
			append/only result do compose [action (args)] ]
	]


;print "EXPECTED^/== [4 6 8 10 12 12 18]"
result ] ;list

probe list [[a * b] for a in [1 2 3] for b in [4 5 6] where [even? a * b]]
probe list [[a * b] for a in [1 2 ] for b in [3 4]]
probe list [[a * b + c] for a in [1 2 ] for b in [3 4] for c in [5 6] where [even? a * b + c]]































; 
;range: func [pair [pair! block!] /local start-value end-value increment nb-iter ][ 
;	start-value: first pair 
;	end-value: second pair
;	increment: either start-value < end-value [1][-1]
;	nb-iter: absolute ( end-value - start-value )
;
;	result: copy []
;	append result start-value
;
;	repeat i nb-iter [
;		append result start-value + ( i * increment )
;	]
;	result 
;]
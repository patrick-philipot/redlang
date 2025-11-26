Red [ purpose: "emulate the for of REBOL"]

_for: function [
    "Recreation of the REBOL for that repeats a block over a range of values." 
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

 do [

 	print {for n 10 20 4 [ print n ]}
 	_for n 10 20 4 [ print n ]
 	print {for x 20 10 -3 [ print x ]}
 	_for x 20 10 -3 [ print x ]

 ]
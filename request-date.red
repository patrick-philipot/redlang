Red[ 
	what: "basic replacement for the REBOL request-date"
	from: "popup-modal.red"
]

request-date: func [
	"Request a date."
	message [string!]  "Title"
	/date when [date!] "Default date"
	/local current-date current-year current-month current-day bk-years bk-months short-months
	bk-days-all bk-days
][

	; inside func

	make-years: func [ when [date!]/local start bk inc ][
		start: when/year - 100
		bk: copy []
		repeat inc 200 [ append bk to-string ( start + inc ) ]
		bk
	]

	; main code

	; invariant
	bk-months: copy ["Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"]
	bk-days: copy ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" 
					"16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" 
					"29" "30" "31" ]	

	; current date

	current-date: any [ when now/date]
	current-year: current-date/year
	current-month: current-date/month
	current-day: current-date/day
	name-of-month: copy bk-months/:current-month

	bk-years: make-years current-date


	layout-blk: [
		backdrop snow

		title (message)

	    year: drop-down 70 (to-string current-year) data bk-years 
	    	on-change [ 
		    	current-year: to-integer pick bk-years face/selected
	    	]

	    month: drop-down 70 (name-of-month) data bk-months 
	    	on-change [ 
	    		current-month: face/selected 
	    		name-of-month: copy bk-months/:current-month
	    	]

	    day: drop-down 70 (to-string current-day) data bk-days 
	    	on-change [ 
	    		current-day: face/selected
	    	]

	    button 40x24 "OK" [
	    	either error? try [current-date: load rejoin [current-year "-" name-of-month "-" current-day]]
	    	[
	    		print "invalid date"
	    		halt
	    	][
	    		unview
	    	]
	    ]

	]

	view/flags compose layout-blk [popup]


	;;; debug

	if message == "***dump" [
		foreach var [current-date current-year current-month name-of-month current-day 
		bk-years bk-months bk-days][ probe :var print reduce [ var ]]
	]

	probe bk-months

	return current-date
]

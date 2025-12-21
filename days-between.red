Red[
	title: "Days Between"
	from: "days-between.red"
]

; loading request-date
do %request-date.red

; fixed to-date
to-date: func [ date-as-string [string!] "dd-Mon-YYYY"] [ return load date-as-string ]

; layout

sd: ed: now/date    

layout-blk: [
	backdrop snow
	title "Days between two dates"

	style btn: button 120

    btn "Select Start Date" [
        sd: request-date/date "Starting date" sd
        sdt/text: to-string sd
        show sdt 
        db/text: to-string ((ed: to-date edt/text) - sd)
        show db
    ]

    ;   START Date

    sdt: field (to-string sd) [
        either error? try [to-date sdt/text] [
            alert "Improper date format."
        ] [
            db/text: to-string ((ed: to-date edt/text) - (sd: to-date sdt/text))
            show db
        ]
    ]

    return

    btn "Select End Date" [
        ed: request-date/date "Ending date" ed
        edt/text: to-string ed 
        show edt 
        db/text: to-string (ed - (sd: to-date sdt/text)) 
        show db
    ]

    ;	END Date

    edt: field (to-string ed) [
        either error? try [to-date edt/text] [
            alert "Improper date format."
        ] [
            db/text: to-string ((ed: to-date edt/text) - (sd: to-date sdt/text))
            show db
        ]
    ]

    return

    text "Days Between Start Date and End Date"

    return

    db: field "0" 230 center yellow red [
        either error? try [to-integer db/text] [
            alert "Please enter a number."
        ] [
        	ed: sd + (to-integer db/text)
            edt/text: to-string ed
        ]
        show edt
    ]

] ; layout-blk

view/options compose layout-blk [offset: 900x560]

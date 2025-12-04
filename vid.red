Red [title: "list of REBOL predefined styles"]

my-img: img: draw 24x24 [pen red fill-pen red triangle 4x4 4x20 20x12]

view layout [
	title "Document Title"
	below
	h1 "Heading 1"
	h2 "Heading 2"
	h3 "Heading 3"
	h4 "Heading 4"
	h5 "Heading 5"
	;banner "Video Title"
	;vh1 "Video heading 1"
	;vh2 "Video heading 2"
	;vh3 "Video heading 3"
	text "Document body text"
	;tt "The teletype font for fixed width text"
	;code "Same as TT except defaults to bold"
	;vtext "Inverse video body text"
	;txt "An alias for BODY style above"
	;label "Used for specifying GUI text labels"
	;lbl "The video equivalent of LABEL"
	field "Text entry field" 
	;info "Same as FIELD style, but read-only"
	area "Text editing area for paragraph entry"
	do [print "do called inside a layout"]
	image my-img
	box blue return
	;icon %nyc.jpg "NYC"
	;led
	button "Button"
	toggle "Toggle"
	;rotary "Rotary"
	;choice "Choice"
	check
	radio
	;arrow
	progress
	slider 200x16
	text-list "A simple form of the LIST style"
]
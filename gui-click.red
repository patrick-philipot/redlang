Red[
	what: "detect mouse click and position"
	tag: "(feel engage) rate origin on-time"
	from: "http://re-bol.com/rebol.html#section-7.6 by Nick Antonaccio"
]

print "Click anywhere in the window, then click the text." 

view center-face layout [
    size 400x200

    box 400x200 snow on-down [ 
            print [ "down at " event/offset ]
	]

	origin 5x5
	below

	text "Click me" [
		print "Text clicked"
		][	
		print "Text right-clicked"
		] 
	
	box blue [print "Box clicked"]

	text "This text has a timer event attached." rate 00:00:00.5 on-time [
		print "1/2 second has passed."] 


] ; layout
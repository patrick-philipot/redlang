Red[
	title: "VID Shooter"
	what: {a little shooting game that uses a timer event to automate the movement of GUI graphics around the screen, check for collisions, and control other game operations}
	tag: "(feel engage btn join) rate style rejoin"
	from: "http://re-bol.com/rebol.html#section-7.6 by Nick Antonaccio"
]

score: 0   speed: 20   fire: false
do game: [
    view center-face layout [
        size 600x440
    	style btn: button

        at 270x10 text "score"
        at 300x100 sc: text score

        ; x == bullet
        at 280x440 x: box 2x20 red
        ; y == alien
        at (as-pair 0 (random 300) + 30) y: btn 50x20 red "Alien"
        ; z == player
        at 280x410 z: btn 100 blue "Player"

        box 600x440 glass rate speed on-time [
            y/offset: y/offset + 5x0
            if y/offset/1 > 600 [
                y/offset: as-pair -10 ((random 300) + 30)
            ]
            show y
            if fire = true [x/offset: x/offset + 0x-20]
            if x/offset/2 < 0 [
                x/offset/2: 440 
                fire: false
            ]
            show x
            if within? x/offset y/offset 50x25 [
                print "Kablammmm!!!"
                score: score + 1
                speed: speed + 5
                fire: false
                unview
                do game
            ]
        ] on-key-up [
        	print event/key
	       	switch event/key [
	       		left [	z/offset: z/offset + -10x0 show z]
	        	right [	z/offset: z/offset + 10x0 show z]
	        	#" " [
			            if fire = false [
			                fire: true 
			                x/offset: as-pair (z/offset/1 + 50) 440
			            ]
        			]
	        ] 
    	] focus
	]
]


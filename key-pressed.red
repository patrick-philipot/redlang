Red [ needs: 'view]
;;;; get a keypress ;;;;
view/options [ 
	title "actors and on-key event"
	t: h3 "hit 'space', 'x', or 'q' keys !"
][
	actors: object [on-key: func [key event] [
	if event/key = #"x" [t/text: "'x' key pressed."]
	if event/key = #"q" [t/text: "'q' key pressed."]
	if event/key = #" " [t/text: "'space bar'pressed."]
	if event/key = #"^M" [t/text: "Return. key pressed"]
]]]
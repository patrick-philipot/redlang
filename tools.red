Red [
	needs: 'view
	purpose: "group often used Red programs"
]

blk: load %tools.txt

lay: copy []

append lay [title "My TOOLS"
			style btn: button 100
			space 4x1
			across
			]

template1: [ do load (to-file rejoin [ "XXX" %.red ] ) ]
template2: [ btn "XXX" ]

repeat i length? blk [
	append lay replace copy template2 "XXX"  pick blk i
	b1: replace/deep copy/deep template1 "XXX" pick blk i
	append/only lay compose b1
	if 0 == mod i 4 [ append lay 'return ]
]

view layout lay
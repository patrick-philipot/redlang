Red [
	needs: 'view
	purpose: "group often used Red programs"
]

blk: load %tools.dat

lay: copy []

append lay [title "My TOOLS"
			style btn: button 100
			space 4x1
			across
			]

; buttons template
template: [ btn "XXX" [ do load (to-file rejoin [ "XXX" %.red ] ) ] ]

repeat i length? blk [
	append lay compose/deep replace/deep/all copy/deep template "xxx" blk/:i
	if 0 == mod i 4 [ append lay 'return ]
]

probe lay

view layout lay
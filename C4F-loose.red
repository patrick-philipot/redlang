Red [needs: 'view]

view [
	title {From Code4Fun / using 'loose', 'on-up', 'offset'} 
	size 450x200
	b: box red white "Drag/Drop" loose on-up [
		if b/offset/x > 370 [print "X right side boundary" b/offset/x: 220] 
		if b/offset/x < 0 [print "X left boundary" b/offset/x: 1]
		if b/offset/y > 120 [print "Y bottom boundary" b/offset/y: 120]
		if b/offset/y < 0 [print "Y top boundary" b/offset/y: 1]
		b/text: form round b/offset print round b/offset
		]
	
]
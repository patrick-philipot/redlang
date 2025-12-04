Red [ needs: 'view]

l-triangle: [ draw: [pen black fill-pen black triangle 20x4 20x20 4x12]]
r-triangle: [ draw: [pen black fill-pen black triangle 4x4  4x20 20x12]]
img: draw 24x24 [pen red fill-pen red triangle 4x4 4x20 20x12]

view layout [
	title "Arrows for Red" size 200x100 
	style arrow: base 24x24 transparent across

	arrow with l-triangle [probe face/draw] 
	arrow with r-triangle [probe face/draw] 
	button 24x24 img [probe face/image] 
]

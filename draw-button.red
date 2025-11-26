Red [needs: 'view]

l-triangle: [draw: [pen black fill-pen black triangle  20x4 20x20 4x12]]
r-triangle: [draw: [pen black fill-pen black triangle  4x4  4x20 20x12]]



my-img: draw 24x24 []
;fleche: draw 24x24 [arrow 0.0.0 0.7 rotate 270]
fleche: draw 24x24 [pen black fill-pen black  triangle 4x4 4x20 20x12]
img-left: draw 24x24 [pen pink fill-pen pink  triangle 4x4 4x20 20x12 rotate 90 12x12]
fleche: draw 24x24 [pen black fill-pen black  triangle 4x4 4x20 20x12]
blue-triangle: [pen blue fill-pen blue  triangle 4x4 4x20 20x12]

color-triangle: function [color [word!]][
	return replace/all [pen _col_ fill-pen _col_  triangle 4x4 4x20 20x12] '_col_ color
]


draw my-img [pen black fill-pen red circle 12x12 10]
green-img: draw 24x24 [pen black fill-pen green circle 12x12 10]
blue-img: draw 24x24 [pen black fill-pen navy circle 12x12 10]
yellow-img: draw 24x24 [pen black fill-pen yellow circle 12x12 10]

img24: draw 24x24 []

place-holder-image: draw 1x1 []

probe color-triangle 'gold

view layout [
	size 400x430
	backdrop silver

	style bbox: base 24x24 place-holder-image
	style cbox: base 24x24 transparent


	base white 300x24 {box 24x24 my-img [ print "hello"]}
	box 24x24 my-img [ print "hello"]
	return

	b: button 24x24 my-img [ probe b/image ] return

	me: box 24x24 green do [me/image: my-img] return

	me2: box 24x24 green with [me2/image: green-img][print "me2"] return

	me3: box 24x24 green with [me3/image: blue-img][probe face/image] return

	me4: bbox with [image: green-img][probe face/image] return
	; 
	me5: cbox with [image: green-img][probe face/image] return

	me6: cbox with [image: img-left][probe face/image] return

	me7: cbox white with [draw: [pen red fill-pen red  triangle 4x4 4x20 20x12]][probe face/draw] return
	
	me8: cbox white with [draw: blue-triangle][probe face/draw] return

	me9: cbox white with [draw: color-triangle 'gold][probe face/draw] return
	me0: cbox with l-triangle [probe face/draw] return




] 
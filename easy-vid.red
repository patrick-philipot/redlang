Red [
    needs: 'view
]

; check if image is available
unless exists? %palms.jpg [
	unless palms: load http://data.rebol.com/view/palms.jpg [
		print "cannot load palm.jpg from rebol site"
		print "please use a 320x240 jpg file as a placeholder"
	]

	; reads from site and writes locally %palms.jpg 
	write/binary %palms.jpg read/binary http://data.rebol.com/view/palms.jpg
]


; { marque le début du texte à parser

content: { RED version of the easy-vid.r REBOL example (RED 0.66 macos Mojave)

===Introduction to VID

With RED/View it's easy and quick to create your own user interfaces. The
purpose of this tutorial is to teach you the basic concepts or RED/View
interfaces in about 20 minutes.

VID is RED's Visual Interface Dialect.  A dialect is an extension of the 
RED language that makes it easier to express or describe information, 
actions, or interfaces.  VID is a dialect that provides a powerful method
of describing user interfaces.

VID is simple to learn and provides a smooth learning curve from basic user
interfaces to sophisticated distributed computing applications.

---Creating VID Interfaces

VID interfaces are written in plain text. You can use any text editor to 
create and edit your VID script. Save your script as a text file, 
and run it with RED/View.

!Note: Using a word processor like Word or Wordpad is not recommended 
because files are not normally saved as text. If you use a word processor, 
be sure to save the output file as text, not as a document (.doc) file.

===Minimal VID Example

Here is a minimal VID example.  It creates a window that displays a short 
text message.  Only one line of code is required:

	view layout [text "Hello RED World!"]

You can type this line at the RED console prompt, or save it in a text 
file and run it with RED.  If you save it as a file, the script will also
need a RED header. The header tells RED that the file contains a script. 
Here is an example of the script file with a header:

	RED [Title: "Example VID Script"]
	view layout [text "VID Example!"]

You can also add buttons and other gadgets to the script. The example below displays a text, list of files, and a button:

	view layout [
		h2 "File List:"
		text-list data read %.
		button "Great!"
	]

!Click on the examples above to see how they will appear on your screen.  
Click on their close box to remove them.  All of the examples that follow 
can be viewed this way.

===Two Basic Functions

Two functions are used to create graphical user interfaces in RED: 
VIEW and LAYOUT.

The LAYOUT function creates a set of graphical objects.  These objects are
called faces.  You describe faces with words and values that are put into
a block and passed to the LAYOUT function.

The VIEW function displays faces that were previously created by LAYOUT. 
The example below shows how the result of the LAYOUT function is passed 
to the VIEW function, and the interface is displayed.

	view layout [
		text "Layout passes its result to View for display."
		button "Ok"
	]

Click on the above example to view it.

!Note: the block provided to a layout is not normal RED code, it is a 
dialect of RED.  Using a dialect makes it much easier to express user 
interfaces.

===Styles

Styles describe faces.  The examples above use the text and button styles 
to specify a text line and a button. RED has some predefined face styles. 
You can also create your own custom styles.  Here are a few examples:

	view layout [
		below
		h1 "Style Examples"
		box brick 240x2
		button "Great"
		text-list 120x80 data ["this is" "a list" "of text"]
		across
		check "check Me"
		radio "Radio 1" radio "Radio 2"
		return
		field 100 "Type text here"
	]

The words like backdrop, banner, box, text, and button are styles.

!At the moment (oct 2025/RED 0.66) banner is not available, at least for macOS.

===Facets

!RED syntax not fully compatible. Text color is set with font.

Facets let you modify a style.  For instance, you can change the color, 
size, text, font, image, and many other facets of a style.

Facets follow the style name.  Here is an example that shows how you 
modify the text color and background:

	view layout [text bold navy "Text red on navy" font [color: red]]


Many facets that can be specified.  Here is an example that creates bold
red text centered in a black box.

	view layout [text 300 bold black center "Red Text" font [color: red]]

!Gradient are not (yet?) available in RED.

===Custom Styles

Custom styles are shortcuts that save time.  When you define a custom 
style, the facets you need go into the new style.  This reduces what you
need to specify each time you use the style, and it allows you to modify
the look of your interface by changing the style definitions.

!Syntax changed in RED, style name ends with : (set-name!) 

	view layout [
		style red-btn: button bold font [color: red]
		text "Testing red button style:"
		red-btn "Test"
		red-btn "Red"
	]

So, if you wanted to create a text style for big, bold, underlined, 
yellow, typewriter text:

	view layout [
		style yell: text 220 bold underline yellow font-size 16
		yell "Hello" return
		yell "This is big old text." return
		yell "Goodbye" return
	]


===Note About Examples

!From this point forward, all examples will assume that the view and 
layout functions are provided.  Only the layout block contents will be 
shown. To use these examples in your scripts, you will need to put them
in a layout block, as was shown earlier.

For example, code that is written as:

	view layout [button "Test it"]

will now appear as:

	button "Test it"

===Face Sizes

The size of a face depends on its style.  Most styles, such as buttons, boxes,
checks, text-lists, and fields, have a default size.  Here are some examples.

	below
	button "Button"
	toggle "click me"
	box blue
	field "type here"
	text-list data [ "one" "two" "three"]

If no size is given, text will automatically compute its size, and images will use
whatever their source size is:

	below
	text "Short text line"
	text "This is a much longer line of text than that above."
	image %palms.jpg

You can change the size of any face by providing a size facet. The size can be
an integer or a pair.  An integer specifies the width of the face.  A pair 
specifies both width and height. Images will be stretched to fit the size.

	below
	button 200 "Big Button"
	button 200x100 "Huge Button"
	image %palms.jpg 50x50
	
===Color Facets

!Colors have no effects in RED with button, or image.

Most styles have a default color. To modify the color of a face, provide a color
facet:

	button blue "Blue Button"
	h2 red "Red Heading"
	image %palms.jpg orange

Colors can also be specifed as tuples. Each tuple contains three numbers: the
red, green, and blue components of the color. 
Component value ranges from 0 to 255. 

	button 200.0.200 "Red + Blue = Magenta" 200
	image %palms.jpg 0.200.200 "Green + Blue"

Some face styles also allow more than one color.  The effect of the color 
depends on the style.  For text styles the first color will be used for the
background and the second color for the text:

	text "Yellow on red background" yellow red

!With REBOL, the first color is for the text, the second for the background.


===Text Facets

Most faces will accept text to be displayed.  Even graphical faces can display
text. For example, the box and image faces will display text if it is provided:

	box blue "Box Face"
	image %palms.jpg "Image Face"

With REBOL, when other datatypes need to be displayed as text, you have to
use the form function to convert them first, it's not supported with RED. You may try to use data instead.

	field data first read %.
	button red 200 data now

!The data causes no error here, but nothing is displayed.

===Normal Text Style

Normal text is light on dark and can include a number of facets to set the
font, style, color, shadow, spacing, tabbing, and other attributes.

	text "Normal"
	text "Bold" bold
	text "Italic" italic
	text "Underline" underline
	text "Bold italic underline" bold italic underline
	text "Big" font-size 32
	text "Serif style text" font-name font-serif
	text "Spaced text" font [space: 5x0]

!In RED, these predefined styles do not exist :

-banner "Banner" 200
-vh1 "Video Heading 1"
-vh2 "Video Heading 2"
-vh3 "Video Heading 3"
-label "Label"

===Document Text Style

Document text is dark on light and can also include a number of facets to set
the font, style, color, shadow, spacing, tabbing, and other attributes.

	text "Normal"
	text "Bold" bold
	text "Italic" italic
	text "Underline" underline
	text "Bold italic underline" bold italic underline
	text "Big" font-size 32
	text "Serif style text" font-name font-serif
	text "Spaced text" font [space: 5x0]

Document text also includes these predefined styles:

	title "Centered title"
	h1 "Heading 1"
	h2 "Heading 2"
	h3 "Heading 3"
	h4 "Heading 4"
	; tt "Typewriter text"
	; code "Code text"

!In RED, tt and code are not predefined. As for title, it's used to set the
window title.

===Text Entry Fields

Text input fields accept text until the enter or tab key is pressed.  A text input
field can be created with:

	field

To make the field larger or smaller, provide a width:

	field 30
	field 300

Fields will scroll when necessary.

Larger amounts of text can be entered in an area.  Areas also accept an enter
key and will break lines.

	area

You can also specify the area size:

	area 160x200

To force the text in an area to wrap rather than scroll horizontally, provide
the wrap option:

	area wrap

===Text Lists

Text lists are easy to create.  Here is an example.

	text-list data ["Eureka" "Ukiah" "Mendocino"]

Almost any type of block can be provided. Here is a list of all the files in
your current directory:

	text-list data read %.

There is no selection by default. The facet selected gives the index of selected
string or none value if no selection (read/write).

	layout [
		below
		chosen: text "empty"	
		all-days: text-list 
		data days: copy [ "Monday" "Tuesday" "Wednesday" "Thursday" ] 
		[ chosen/data: pick days all-days/selected ]
	]

===Images

By default an image will be scaled to fit within a face.

	image 60x60 %palms.jpg

Most other faces can accept an image as well as text:

	box 100x100 %palms.jpg
	button "Button" %palms.jpg

The image can be provided as a filename, URL, or image data.

===Backdrops

A backdrop can be a color, or an image. For example a backdrop color would be
written as:

	backdrop navy
	text "Color Backdrop" gold

A backdrop image can be a file, URL, or image data:

	backdrop %palms.jpg
	text "Image Backdrop" red


===Effect Facets

!No effect in RED

A range of effects are supported for faces.  All of these effects are
performed directly on the face when it is rendered. Here are examples
of a few possible effects:

Effects can be used in combination to create other interesting results.
However, keep in mind that the computations are performed in real time.  
If complex combinations are required, a temporary image should be created
with the to-image function.

===Actions

An action can be associated with almost any face. To do so, follow the face
style with a block:

	button "Test" [print "test"]

The block is used as the body of a function that is passed the face and the
current value (if the face has one).  For example:

	text "Click Here" [print face/text]

If a second block is provide, it is used for the alternate actions (right key):

	button "Click Here" [print "action"] [print "alt-action"]

Use variables to modify the contents or state of other faces. For example, the
slider will update the progress bar:

	slider 200x16 [p1/data: face/data]
	p1: progress


!More on actions needed...

===More to Come

!Much more to come.  These still need to be covered in this
tutorial:

	text-list data [
		"key"
		"check"
		"radio"
		"slider"
		"progress"
		"panel"
		"list"
	]
}

; } marque la fin de CONTENT , le texte à parser
; NE PAS LAISSER de ligne vide à la fin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;  PARSE  ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
page-max: 0
code: text: layo: xview: none
sections: []
layouts: []
space: charset " ^-"
chars: complement charset " ^-^/"

rules: [title some parts]

title: [text-line (title-line: text)]

parts: [
	  newline
	| "===" section
	| "---" subsect
	| "!" note
	| example
	| paragraph
]

text-line: [copy text to newline newline]
indented:  [some space thru newline]

paragraph: [copy para some [chars thru newline] (trim/tail para emit txt para)]
note: [copy para some [chars thru newline] (emit-note para)]
example: [
	copy code some [indented | some newline indented]
	(emit-code code)
]
section: [
	text-line (
		append sections text
		append/only layouts layo: copy page-template
		emit h5 text
	) newline
]
subsect: [text-line (emit h5 text)]

emit: func ['style data] [repend layo [style data]]

emit-code: func [code] [
	remove back tail code
	repend layo ['code code 'show-example]
]

emit-note: func [code] [
	remove back tail code
	repend layo ['tnt code]
]

show-example: [
	if xview [xy: xview/offset  unview/only xview]
	xcode: load/all face/text
	if not block? xcode [xcode: reduce [xcode]] ;!!! fix load/all
	if here: select xcode 'layout [xcode: here]
	xview: view/no-wait layout xcode
]

page-template: [
	size 500x520
	below
	style code: text bold font [name: "Consolas" size: 10 color: blue]
	style tnt: text silver maroon 
	style txt: text silver black
]

parse content rules

page-max: length? sections

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;  VID/GUI  ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

img-right: 

img-left: 



show-page: func [i /local blk][
	tl/selected: i
	this-page: i
	blk: pick layouts i
	f-box/pane: layout/only blk
	show f-box
]

;grey: 200.200.200

; left and right arrow
l-triangle: [draw: [pen black fill-pen black triangle  20x4 20x20 4x12]]
r-triangle: [draw: [pen black fill-pen black triangle  4x4  4x20 20x12]]


main: layout [
	title "Easy-Vid for RED"
	main-title: text bold title-line 610
	style arrow: base 24x24 transparent

	arrow with l-triangle [show-page max 1 this-page - 1]
	arrow with r-triangle [show-page min page-max this-page + 1]
	return

	across

	; liste défilante avec les sections
	tl: text-list 160x520 black data sections [
		show-page max 1 tl/selected
	]

	; zone d'affichage 
	f-box: panel 500x520 silver

]



view/no-wait main
show-page 1
set-focus tl
view main
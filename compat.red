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

save-conf-file: func [path [string!]][
	config: copy {REBOL [ Title: "Configuration file" ]^/ set 'rebol-path "REBPATH"}
	replace config "REBPATH" path
	prin "config >> ^/"
	print config
	write %w6.conf config
]

; load configuration file
if exists? %w6.conf [ do load %w6.conf ]

prepare-rebol-test: func[][

	; test rebol demandé ? (the check on top of the main screen is on)
	if rebol-test [
		; si le chemin vers l'exe rebol est défini tout va bien
		unless value? 'rebol-path [ alert-popup "Please enter the full path to the rebol executable^/example: ~/rebol/rebol" ]
	]
]

test-with-rebol: func [str [string!]][
	; str débute et fini par les marques de bloc [ et ]

	; create the file %rebcod.r
	code-for-rebol: copy {
	REBOL [title: "Rebol program"]
	view layout

	}
	append code-for-rebol str
	write %rebcod.r code-for-rebol

	; command-line for rebol
	cmd: to-file append append copy rebol-path " " %rebcod.r

	; call rebol
	call cmd

]

alert-popup: function [;-- based on work by Nodrygo
    "Displays an alert message"
    msg [string!] "Message to display"
] [
    view/flags [
        msg-text: text msg center return    ;-- center the string INSIDE the text face
        OK-btn: button "OK" [unview] ;-- or user can close window with 'X'
        do [;-- centre the button
            OK-btn/offset/x: to-integer ( msg-text/offset/x + (msg-text/size/x / 2) - (OK-btn/size/x / 2))]
    ] [modal popup]
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;  TEXTE  ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

content: { REBOL/Red/VID code to be tested (RED 0.66 macos Mojave)

===About it

This program allows you to easily test some REBOL/VID codes with RED. They
are loads of them available. In addition, if you have REBOL installed on the
same machine, it's possible to run the code with REBOL and see the result
for comparison.

!Simply click the "Test with rebol" check

In order to test your code, you need to put it in a simple text file 
(ex: mycode.txt) formatted like the text your are reading. Make sure all the
code is between a { and a }, forming a long and unique string. Divide it in
sections, each one long about 30 lines maximum.

A line starting with "===" is a title section. An empty line must follow. The 
current section title is "About it".

Consecutives lines, each indented by one tab characters, form a block of code.
This is an example (you may omit the "view layout" for simplicity):

	view layout [button "Test it"]

Just provide the content of the layout block

	text-list data ["Eureka" "Ukiah" "Mendocino"]
	button 100 "click me"
	check "Are-you happy ?" [either face/data [print "Yes"][print "No"]]

!Click a block to run it with RED (and REBOL possibly). A line starting with an
exclamation point, ! with no space after, is a remark. A section is about 30
lines long, so it's time to start a new one at this point.

===More about it

Besides title, code and remark, paragraphs are formed with non indented lines.
Note the text will not wrap. Each line must end with a carriage return.

This formatting is directly borrowed from the easy-vid.r example.

The present program is indeed very close of the easy-vid provided with REBOL.
Actually easy-vid.r was the first program I attempted to convert in Red-Lang.

To say the least, it was not easy !

For a start, I have now a MacBook Air M1 where neither REBOL nor RED are 
available. Fortunately I also own a brave MacBook (13 pouces, Aluminium 
fin 2008) with macOS Mojave installed (http://dosdude1.com/mojave/). This
is the last macOS version supporting 32bits apps.

I used to code with REBOL a long time ago (20 years at least). REBOL is 
opinionated, smart and elegant. I'm n°17 on the REBOL COOKBOOK
(http://www.rebol.net/cookbook/).

!This code is still valid in RED

I want to share this program with other RED enthousiats. I'll have to find a way...

	text bold navy white "Long live RED"
	image %LongLiveRed.png

}

; } marque la fin de CONTENT , le texte à parser
; NE PAS LAISSER de ligne vide à la fin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;  PARSE  ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	if rebol-test [test-with-rebol mold xcode]
	xview: view/no-wait layout xcode
	; xview: view layout xcode
]

page-template: [
	size 500x520
	below
	style code: text bold font [name: "Consolas" size: 10 color: blue]
	style tnt: text grey maroon 
	style txt: text grey black
]

parse-content: func[][
	page-max: 0
	code: text: layo: xview: none
	sections: []
	layouts:  []
	parse content rules

	page-max: length? sections
	;prin "page-max >> " print page-max
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;  VID/GUI  ;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

img-right: make image! [20x20 #{
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4B1B1B1FFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080040404525252D3D3D3FFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F000000000000101010696969
EFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E7E7E000000000000000000000000
2929299A9A9AFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7D7D7D000000000000000000000000
0000000000003E3E3EC3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C000000000000000000000000
000000000000000000090909616161E4E4E4FFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7C7C7C000000000000000000000000
0000000000000000000000000000001E1E1E929292FFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A000000000000000000000000
0000000000000000000000000505054E4E4ED2D2D2FFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797979000000000000000000000000
000000000000000000383838B3B3B3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF797979000000000000000000000000
0000002020208E8E8EFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF787878000000000000000000121212
737373EEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7777770000000505054E4E4ED2D2D2
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF757575383838B3B3B3FFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5D5FDFDFDFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
}]

img-left: 
make image! [20x20 #{
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFB1B1B1A3A3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFD9D9D95F5F5F060606818181FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3
7B7B7B141414000000000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAAAAA2C2C2C
0000000000000000000000007F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACACA484848010101000000
0000000000000000000000007E7E7EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFE9E9E96E6E6E0C0C0C000000000000000000
0000000000000000000000007D7D7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFF9191911E1E1E000000000000000000000000000000
0000000000000000000000007C7C7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFD9D9D95B5B5B060606000000000000000000000000
0000000000000000000000007B7B7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBABABA434343000000000000000000
0000000000000000000000007A7A7AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD959595262626000000
000000000000000000000000797979FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEE737373
121212000000000000000000787878FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
D9D9D95B5B5B060606000000787878FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFBABABA434343757575FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFDFDFDD7D7D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
}]


show-page: func [i /local blk][
	tl/selected: i
	this-page: i
	blk: pick layouts i
	f-box/pane: layout/only blk
	show f-box
]

new-content: does [
	code-file: request-file/file what-dir 
	; si un fichier a été sélectionne
	if code-file [
		content: load code-file
		parse-content
		show tl
	]
]

grey: 200.200.200

rebol-test: false

; analyse content
parse-content

main: layout [
	title "Compatibility tester for REBOL code with RED (RED 0.66 macos Mojave)"
	backdrop white
	main-title: text bold navy white 230 title-line 
	button 125 green "New content" font [color: red][ new-content ] 
	rebol: check "Test with REBOL too (if installed)" [if rebol-test: rebol/data [prepare-rebol-test]]
	style arrow: button 24x24 
	arrow img-left [show-page max 1 this-page - 1]
	arrow img-right [show-page min page-max this-page + 1]
	return


	; liste défilante avec les sections
	tl: text-list 160x520 black data sections [
		show-page max 1 tl/selected
	]

	; zone d'affichage 
	f-box: panel 500x520 grey return

	across

	text bold navy white 160 "Rebol path >> " 
	f: field "Enter rebol path here" 510 white coffee [save-conf-file rebol-path: f/text]

]

do main-prog: [

	; affiche l'écran principal
	view/no-wait main
	show-page 1
	set-focus tl
	if value? 'rebol-path [f/text: rebol-path]
	view main

]

; quit RED in order to get a fresh context every time
; quit
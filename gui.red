;;;; 
; It allows you to drag and drop widgets to a layout grid, Then the 'Save it' button will save the
;;;; generated script,  the 'Try it' button will allow you to run the script, and the 'Clear it' button will 
;;;; clear the layout page.  There's a lot more that could be added to this one, A compiled exe is on
;;;; my 'Red Apps' page.

Red [needs: 'view author: Alan Brack date: 12/03/2018 ]

spec: copy []
btn-pos: 500x20 rad-pos: 500x50 chk-pos: 500x80 fld-pos: 500x110 ars-pos: 500x140
sdr-pos: 500x170 pgs-pos: 500x200 pnl-pos: 500x230 ddn-pos: 500x260 txt-pos: 500x290
n: 0 n1: 0 n2: 0 n3: 0 n4: 0 n5: 0 n6: 0 n7: 0 n8: 0 n9: 0
view/options/flags [title "GUI Drag-n-Drop Layout(ver. 1)  by Alan B."
size 600x500 
;;;;;;;;;;;;;;; a bit of a grid thing ;;;;;;;;;;;;;;;;
base transparent 480x480 draw [pen brown
text 2x15 ".                .                .                .               .               .               .               ." 
text 2x75 ".                .                .                .               .               .               .               ."
text 2x135 ".                .                .                .               .               .               .               ."
text 2x195 ".                .                .                .               .               .               .               ."
text 2x255 ".                .                .                .               .               .               .               ."
text 2x315 ".                .                .                .               .               .               .               ." 
text 2x375 ".                .                .                .               .               .               .               ." 
text 2x435 ".                .                .                .               .               .               .               ." 
                                ]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 at 490x10 box gray 100x480
;;;;;;;;;;;;;;;;;;;;;Buttons;;;;;;;;;;;;;;;;;;;;;
 at btn-pos
btn: button "Button" loose on-drop [ if btn/offset/x < 410 [
if btn/offset/x > 5 [ if btn/offset/y > 5 [ n: n + 1
name: append copy "Button " n
p: face/offset
repend spec ['at p 'button name []]
repend face/parent/draw ['box p p + face/size 'text p + 4x5 name ]
new-line find/last spec 'at on
;;;; print mold spec   
 ] ] ]
btn/offset: btn-pos
] 80
;;;;;;;;;;;;;;;;;;;;;;;;Radios;;;;;;;;;;;;;;;;;
 at rad-pos
rad: button "Radio" loose on-drop [ if rad/offset/x < 410 [
if rad/offset/x > 5 [ if rad/offset/y > 5 [ n1: n1 + 1
name: append copy "Radio" n1
p1: face/offset
repend spec ['at p1 'radio name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec    
 ] ] ]
rad/offset: rad-pos
] 80
;;;;;;;;;;;;;;;;;;;;;Check Boxes;;;;;;;;;;;;;;;
 at chk-pos
chk: button "Check" loose on-drop [ if chk/offset/x < 410 [
if chk/offset/x > 5 [ if chk/offset/y > 5 [ n2: n2 + 1
name: append copy "Check " n2
p1: face/offset
repend spec ['at p1 'check name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec    
 ] ] ]
chk/offset: chk-pos
] 80
;;;;;;;;;;;;;;;;;;;;;;;Fields;;;;;;;;;;;;;;;;;;
 at fld-pos
fld: button "Field" loose on-drop [ if fld/offset/x < 410 [
if fld/offset/x > 5 [ if fld/offset/y > 5 [ n3: n3 + 1
name: append copy "Field " n3
p1: face/offset
repend spec ['at p1 'field name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec    
 ] ] ]
fld/offset: fld-pos
] 80
;;;;;;;;;;;;;;;;;;;;;;;Areas;;;;;;;;;;;;;;;;;;
 at ars-pos
ars: button "Area" loose on-drop [ if ars/offset/x < 410 [
if ars/offset/x > 5 [ if ars/offset/y > 5 [ n4: n4 + 1
name: append copy "Area " n4
p1: face/offset
repend spec ['at p1 'area name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec    
 ] ] ]
ars/offset: ars-pos
] 80
;;;;;;;;;;;;;;Slider;;;;;;;;;;;;;;;;;;
 at sdr-pos
sdr: button "Slider" loose on-drop [ if sdr/offset/x < 410 [
if sdr/offset/x > 5 [ if sdr/offset/y > 5 [ n5: n5 + 1
name: append copy "Slider " n5
p1: face/offset
repend spec ['at p1 'slider 10% []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec    
 ] ] ]
sdr/offset: sdr-pos
] 80
;;;;;;;;;;;;;;;Progress;;;;;;;;;;;;;;
 at pgs-pos
pgs: button "Progress" loose on-drop [ if pgs/offset/x < 410 [
if pgs/offset/x > 5 [ if pgs/offset/y > 5 [ n6: n6 + 1
name: append copy "Progress " n6
p1: face/offset
repend spec ['at p1 'progress 10% []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name]
new-line find/last spec 'at on
;;;; print mold spec   
 ] ] ]
pgs/offset: pgs-pos
] 80
;;;;;;;;;;;;;;;Panel;;;;;;;;;;;;;;;;;;;;;;;;
 at pnl-pos
pnl: button "Panel" loose on-drop [ if pnl/offset/x < 410 [
if pnl/offset/x > 5 [ if pnl/offset/y > 5 [ n7: n7 + 1
name: append copy "Panel " n7
p1: face/offset
repend spec ['at p1 'panel name yellow[ size 50x100 ]]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name ]
new-line find/last spec 'at on
;;;; print mold spec   
 ] ] ]
pnl/offset: pnl-pos
] 80
;;;;;;;;;;;;;;;;Drop-Down;;;;;;;;;;;;;;;;;;;;
 at ddn-pos
ddn: button "Drop-down" loose on-drop [ if ddn/offset/x < 410 [
if ddn/offset/x > 5 [ if ddn/offset/y > 5 [ n8: n8 + 1
name: append copy "Drop-down " n8
p1: face/offset
repend spec ['at p1 'drop-down name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name ]
new-line find/last spec 'at on
 ;;;; print mold spec    
 ] ] ]
ddn/offset: ddn-pos
] 80
;;;;;;;;;;;;;;;;;Text;;;;;;;;;;;;;;;;;;;;
 at txt-pos
txt: button "Text" loose on-drop [ if txt/offset/x < 410 [
if txt/offset/x > 5 [ if txt/offset/y > 5 [ n9: n9 + 1
name: append copy "Some text " n9
p1: face/offset
repend spec ['at p1 'text name []]
repend face/parent/draw ['box p1 p1 + face/size 'text p1 + 4x5 name ]
new-line find/last spec 'at on
 ;;;; print mold spec    
 ] ] ]
txt/offset: txt-pos
] 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

at 500x410 box khaki 80x75
at 510x420 button font-color red "'Try It'" [view/flags spec ['modal 'no-min] ] 60x15
at 510x440 button font-color red "'Clear It'" [ clear face/parent/draw clear spec
n: 0 n1: 0 n2: 0 n3: 0 n4: 0 n5: 0 n6: 0 n7: 0 n8: 0 
n9: 0 n10: 0] 60x15
 at 510x460 button font-color red "'Save It'" [ if sf: request-file/save [unless suffix? sf [append sf %.red ]
write sf rejoin [{Red [needs: 'view] 
    view }] write/append sf spec ] ] 60x15
][draw: []] ['modal 'no-min]
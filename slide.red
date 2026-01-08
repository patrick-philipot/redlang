;;;;  Not seen one in Red, so thought i'd do one.
;;;;  If you cut and paste this one, it runs the 'intro & settings' first ....
;;;;  then you'll need to hit enter again to run the main slideshow.
;;;;  tested on Windows 8 and 10 - PC, Laptop and Tablet.
;;;;  a slideshow.... it displays all images in the default folder.
;;;;  the delay between all of the images can be set.
;;;;  displays bmp, jpg, png, and gif  images.
Red [needs: 'view author: Alan Brack date: 02/11/2018]
r: 0:0:4 cnt: 0 cnt2: 0
scrn: system/view/screens   ;; <-- get the screen size.
folder: read %.
random/seed now/time
;;;; intro and settings ;;;;
view/flags [ on-close [quit] title "My Slideshow"
size 350x380 backdrop orange
h5 "Click on an image to stop slideshow" return
text font-size 8 "Will display bmp, jpg, png, gif  when in the same folder as this app." return
h5 italic "Set time between images ...." return
radio "2 seconds" [r: 0:0:2] return
radio "3 seconds" [r: 0:0:3] return
radio "4 seconds" data on [r: 0:0:4] return
radio "5 seconds" [r: 0:0:5] return
radio "6 seconds" [r: 0:0:6] return
radio "7 seconds" [r: 0:0:7] return
button font-color red bold "Run Show" [unview]
] ['modal 'popup]
;;;; main slideshow ;;;;
forever [
foreach file random folder [ foreach ext [".jpg" ".gif" ".png" ".bmp"] [
if find file ext [ran: random linen purple yellow linen red blue white black
i: load file pos: scrn/1/size - i/size / 2 ;; <--  load and centre image
 cnt: cnt + 1
view/flags [size scrn/1/size backdrop ran
at pos image i [quit] rate r on-time [unview] ;;<-- display image and set timer
 ] ['modal 'no-border] ;; <-- end of  view  block
 ]  ;;<-- end of  if find  block
 ]  ;; <-- end  foreach ext   block
 ]  ;; <- end of  foreach file  block
;;;;;; this bit detects for no images in the folder ;;;;;;
;;;;;; very important as we are in a forever loop ;;;;;
 cnt2: cnt2 + 1 if cnt2 > cnt [view/flags [on-close [quit] title "Warning !"
h1 font-color red "No image files in this folder" return
button "Quit" [quit] ] ['modal 'popup] ]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ] ;; <-- end of  forever  block
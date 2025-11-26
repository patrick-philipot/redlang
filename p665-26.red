Red [needs: 'view']

about: 
{; Here we have 4 fields 'fv1, 'fv2, 'fv3, 'fv4
; The idea is to get one by its number
; building the litteral name, like "fv1"}

change-fv: func [
    /local n w f
][
    n: random 4
    ; build a word from the string "fv" + n
    w: to-word rejoin ["fv" n]

    ; get the global variable attached/bind the w
    f: get :w

    ; it works ! ! !
    f/text: form reduce [w " has been changed"]
    show f
] ;cf

fav: layout [
	title "p665-25.red"
	size 400x290
    style fv: text 200 bold "text"

    below
    area 380x100 font-size 14 gold  with [text: about]

    fv1: fv "To be changed soon"
    fv2: fv "To be changed soon"
    fv3: fv "To be changed soon"
    fv4: fv "To be changed soon"

    button 380 font-color red bold "Change text" [change-fv]

] ; layout

view center-face fav

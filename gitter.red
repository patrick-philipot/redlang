#!/Users/user1234/red/red-view.app/Contents/MacOS/red-view-19mar25-6942c7a02
Red[
	Needs: 'View
]
;--without pad and with react
names: ["Carl Sassenrath" "David Oliva (Oldes)" "Nenad Rakocevic" "Chris Lattner"]
languages: ["Rebol 2" "Rebol 3" "Red" "Swift"]
win: layout [
    title "Picker"
    below center
    text "Languages" center font-size 14
    drop: drop-list data languages select 1 
    H2 300 center react [face/text: names/(drop/selected)]
    button "Quit" [quit]
]
view win


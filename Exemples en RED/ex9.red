Red [needs: 'view]
h: load %heads.jpg
t: load %tails.jpg
view [
    title "Coin Flip"
    below
    i: image h
    f: field
    button "Flip" [
        f/text: first random ["Heads" "Tails"]
        either f/text = "Heads" [i/image: h] [i/image: t] 
    ]
]

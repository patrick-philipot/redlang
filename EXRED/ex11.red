Red [needs: 'view]
xx: form x: ["brilliant" "rare" "unique" "talented" "exceptional"]
yy: form y: ["genius" "champion" "winner" "success" "achiever"]
view [
    title "Compliment Generator"
    below
    area xx
    area yy
    button "Compliment" [
        print [
            "You're a"
            first random x
            first random y "!"
        ]
    ] 
]

Red [needs: 'view]
view [
    title "Tip Calculator"
    below
    f: field "9"
    t: field ".19" 
    button "Calculate" [
        append clear x/text (to float! f/text) * (1 + (to float! t/text))
    ]
    x: field "tip"
]

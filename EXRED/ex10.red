Red [needs: 'view]
x: func [] [append append form random 10 " + " form random 20]
view [
    title "Math Test"
    f1: field 
    f2: field "Answer_here..."
    button "Check Answer" [
        print either f2/text = form do f1/text ["Yes!"]["No"]
        f1/text: x
        f2/text: ""
    ]
    do [f1/text: x]
]

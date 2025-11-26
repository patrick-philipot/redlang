p665-bind-3.r

Rebol [title: "Exemple 10.3"]

; prepared block
b-sum:  [nb1 + nb2 + nb3] 
b-prod: [nb1 * nb2 * nb3]
b-aver: [(nb1 + nb2 + nb3) / 3]

fn-calculate: func [cb [block!]][
    return do cb
]

nb1: to-decimal ask "Enter number 1 :"
nb2: to-decimal ask "Enter number 2 :"
nb3: to-decimal ask "Enter number 3 :"

print "Your choice"
print "Sum      - 1 "
print "Product  - 2 "
print "Average  - 3 "

choice: ask "1|2|3 ? "

switch choice [
    "1"     [calcul-bloc: b-sum] 
    "2"     [calcul-bloc: b-prod]
    "3"     [calcul-bloc: b-aver]
]

fn-calculate calcul-bloc
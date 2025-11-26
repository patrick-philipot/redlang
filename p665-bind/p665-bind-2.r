p665-bind-2.r

Rebol [title: "Exemple 10.2"]

; prepared block
b-sum:  [nb1 + nb2 + nb3] 
b-prod: [nb1 * nb2 * nb3]
b-aver: [(nb1 + nb2 + nb3) / 3]


nb1: to-decimal ask "Enter number 1 :"
nb2: to-decimal ask "Enter number 2 :"
nb3: to-decimal ask "Enter number 3 :"

print "Your choice"
print "Sum      - 1 "
print "Product  - 2 "
print "Average  - 3 "

choice: ask "1|2|3 ? "

switch choice [
    "1"     [print ["Sum is "  do b-sum]] 
    "2"     [print ["Product is " do b-prod]]
    "3"     [print ["Average is " do b-aver]]
]
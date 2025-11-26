p665-bind.r

Rebol [title: "Exemple 10.1"]

nb1: to-decimal ask "Enter number 1 :"
nb2: to-decimal ask "Enter number 2 :"
nb3: to-decimal ask "Enter number 3 :"

print "Your choice"
print "Sum      - 1 "
print "Product  - 2 "
print "Average  - 3 "

choice: ask "1|2|3 ? "

switch choice [
    "1"     [print ["Sum is "  nb1 + nb2 + nb3] ] 
    "2"     [print ["Product is " nb1 * nb2 * nb3]]
    "3"     [print ["Average is " (nb1 + nb2 + nb3) / 3]]
]
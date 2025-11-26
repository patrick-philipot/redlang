p665-bind-6.r

Rebol [title: "Exemple 10.6"]

; prepared block
b-sum:  [nb1 + nb2 + nb3] 
b-prod: [nb1 * nb2 * nb3]
b-aver: [(nb1 + nb2 + nb3) / 3]

fn-calculate: function [
    nb1 [decimal!]
    nb2 [decimal!]
    nb3 [decimal!]
    cb [block!]
] [f] [
    f: func [nb1 nb2 nb3] cb
    f nb1 nb2 nb3
]

num1: to-decimal ask "Enter number 1 :"
num2: to-decimal ask "Enter number 2 :"
num3: to-decimal ask "Enter number 3 :"

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

print ["Result: " fn-calculate num1 num2 num3 calcul-bloc]

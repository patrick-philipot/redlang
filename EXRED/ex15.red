print "Calcul factorielle à la HASKELL"
print "-------------------------------"


factorial: func [n][
    case [
        n = 0 [1]
        true  [n * factorial n - 1]
    ]
]



source factorial

print [ "factorial 6 > " factorial 6 ]
print [ "factorial 5 > " factorial 5 ]
print [ "factorial 4 > " factorial 4 ]
print [ "factorial 3 > " factorial 3 ]
print [ "factorial 2 > " factorial 2 ]
print [ "factorial 1 > " factorial 1 ]

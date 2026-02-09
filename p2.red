Red[what: "parse string"]



boundary: charset [ #"*" ]
not-boundary: charset [ not #"*"]
word: [ boundary [some not-boundary] boundary ]
parse-rules: [ any not-boundary any word any not-boundary ]

input: {abc*word*abc}

parse-trace input parse-rules













; ------------------------
halt
; ------------------------
sentence: "This is a sentence"

parse sentence [any [[any space] copy text [to space | to end ] (print text) skip]]


;; Using load/as
data: load/as {{"name": "Alice", "age": 30}} 'json


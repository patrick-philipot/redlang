Red[what: "parse json"]



quote: charset [ #"^"" ]
not-quote: charset [ not #"^"" ]

;? quote
;? not-quote

word: [ quote [some not-quote] quote ]
;parse-rules: [ any not-quote  word  any not-quote ]
parse-rules: [ any not-quote any word any not-quote ]

input: {"word"}


parse-trace input parse-rules













; ------------------------
halt
; ------------------------
sentence: "This is a sentence"

parse sentence [any [[any space] copy text [to space | to end ] (print text) skip]]


;; Using load/as
data: load/as {{"name": "Alice", "age": 30}} 'json


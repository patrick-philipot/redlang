Red[what: "parse string"]

wb: copy []

boundary: charset [ #"^"" ]
not-boundary: charset [ not #"^""]
word: [ boundary [ some not-boundary ] boundary ]
chunk: [ [ word #":" word ] | [word #":" #"[" #"]" ]]
parse-rules: [ some chunk ]

;input: {abc "word" abc}

input: read %chuck.db

parse-trace input parse-rules
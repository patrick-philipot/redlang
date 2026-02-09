Red[what: "parse string"]

wb: copy []

boundary: charset [ #"^"" ]
not-boundary: charset [ not #"^""]
word: [ boundary [ some not-boundary ] boundary ]
parse-rules: [ any not-boundary copy text any word ( append wb text ) any not-boundary ]

input: {abc "word" abc}

;input: read %chuck.db

parse input parse-rules
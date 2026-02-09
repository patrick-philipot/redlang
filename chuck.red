Red[ 
	what: "Using Check Norris joke API"
]

; do %./red/altjson.red

do %./red-json-master/json.red

response: read https://api.chucknorris.io/jokes/random

print response

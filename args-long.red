#!/opt/red-view
;Red []

; Get arguments from system/script/args
args: system/script/args

; Check if arguments were provided
either args [
    print ["Received arguments:" args]
    
    ; If args is a string, you can parse it
    if string? args [
        parts: split args " "
        print ["Number of arguments:" length? parts]
    ]
][
    print "No arguments provided."
    halt
]

filename: first parts
print reduce [ filename " is of type " type? filename ]
print reduce [ "first of filename " first filename ]
print reduce [ "last of filename " last filename ]
print reduce [ "length of filename " length? filename ]
print "probe of filename shows " probe filename 


if error? try [ read/binary to-file filename ][
	print "/\/\/\/\/\/\/\/\WORKAROUND/\/\/\/\/\/\/\/\/\/\"
	; get rid of last '
	print filename: copy/part filename 13
	; get rid of first '
	print filename: copy skip filename 1
]

print copy/part read/binary to-file filename 40
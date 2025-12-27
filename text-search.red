Red[ 
	what: "Simple tool for searching text in text files only recursively" 
	from: "http://re-bol.com/rebol.html#section-10.4"
]

request-text: func [
    "Requests a text string be entered."  
    /title title-text 
    /default str
    /local text-lay returned-value
][
	if none? str [str: copy ""] 
	returned-value: none 
	text-lay: layout compose [
			backdrop snow
			title (title-text)

			tf: field 300 yellow red str return

			button "Ok" [ returned-value: tf/text unview  ]
			button "Cancel" [ unview () ]
	]
	view/flags text-lay [popup]
	returned-value
]


; saving current-dir
init-dir: what-dir

phrase: request-text/title/default "Text to Find:" "sublime"
start-folder: request-dir/title "Folder to Start In:"
change-dir start-folder
found-list: ""
text-extensions: [ %.txt %.dat %.red %.db %.md %.sh]

recurse: func [current-folder] [ 
    foreach item (read current-folder) [ 
        ; handle 2 or 3 letters extensions 
        if all [not dir? item find text-extensions find/last item "."][  if error? try [
            if find (read to-file item) phrase [
                print rejoin [{"} phrase {" found in:  } what-dir item]
                found-list: rejoin [found-list newline what-dir item]
            ]] [print rejoin ["error reading " item]]
        ]  

    ]
    foreach item (read current-folder) [ 
        if dir? item [
            change-dir item 
            recurse %./
            change-dir %../
        ] 
    ]
]

print rejoin [{SEARCHING for "} phrase {" in text files from } start-folder "...^/"]
recurse %./
print "^/DONE^/"

; restoring init-dir
change-dir init-dir

print found-list


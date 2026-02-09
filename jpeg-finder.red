Red[ 
	what: "Searching image files recursively" 
	from: "http://re-bol.com/rebol.html#section-10.4"
]

; dockimble special to clear the console as CLS for BASIC or clear for BASH
clean: does [
  do bind [
    full?:      no
    top:        1
    scroll-y:   0
    line-y:     0
    line-cnt:   0
    screen-cnt: 0
    line-pos:   1
    clear lines
    clear nlines
    clear heights
    clear selects
    gui-console-ctx/scroller/page-size: page-cnt
    gui-console-ctx/scroller/max-size: page-cnt - 1
    gui-console-ctx/scroller/position: 0
  ] gui-console-ctx/terminal
  system/view/platform/redraw gui-console-ctx/console
  ()
]

; saving current-dir
init-dir: what-dir

start-folder: request-dir/title "Folder to Start In:"
change-dir start-folder
found-list: copy []
text-extensions: [ %.jpg %.jpeg ]

recurse: func [current-folder] [ 
    print what-dir
    append found-list what-dir
    foreach item (read current-folder) [ 
        ; handle 2 or 3 letters extensions 
        if all [not dir? item find text-extensions find/last item "."][

                print [item]
                append found-list item
                ;found-list: rejoin [found-list newline what-dir item]
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

clean

print rejoin [{SEARCHING for MP4 in } start-folder "...^/"]
recurse %./


; restoring init-dir
change-dir init-dir

foreach item found-list [ print item ] 

; print found-list


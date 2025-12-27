Red[ 
	what: "List files extensions found in given directory" 
	from: "text-search.red"
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
]

; saving current-dir
init-dir: what-dir


clean()

print "Extensions.red :: find all file extensions for a given directory"
ask "Press a key to select the directory to explore "

start-folder: request-dir/title "Folder to Start In:"
change-dir start-folder

all-extensions: copy []

recurse: func [current-folder] [ 
    foreach item (read current-folder) [ 
        if not dir? item [  
            ext: find/last item "."
            if any [ 3 == length? ext 4 == length? ext] [
                if not find all-extensions ext [ append all-extensions ext ]
            ]
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


recurse %./


; restoring init-dir
change-dir init-dir

clean ()
print "Found extensions:"
probe all-extensions ()


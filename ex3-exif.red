Red[ 
	what: "extract EXIFcdatetime/original from all images of a given folder" 
]

do load %dto-exif.red

; set to true for more details
debug: false

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

alert: func [ message [string!] ][
    blk: compose [
        title "Recherche d'images pour LightRoom"
        text (message) return
        button "OK" [ unview ]  
    ]
    view/flags layout blk [popup]
]

collect-img: func [][
    ; saving current-dir
    init-dir: what-dir

    alert "Dans la fenêtre suivante, sélectionnez un répertoire à explorer"
    start-folder: request-dir/title "Folder to Start In:"

    ; start-folder: %/Users/user1234/red/redlang/EXIF-TEST/

    img-extensions: [ %.jpg %.jpeg %.png ] ; no need to use uppercase version

    print rejoin [{SEARCHING for JPEG/PNG in } start-folder "...^/"]

    change-dir start-folder

    count: 0

    foreach item (read start-folder) [ 
        ; only process images
        if all [not dir? item find img-extensions find/last item "."][
            count: count + 1
            if debug [ print rejoin [count ") " start-folder item] ]
            append blk-files rejoin [start-folder item]
        ]
    ] 
    ; restoring init-dir
    change-dir init-dir
    count
]

; /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MAIN
;
clean

; store image paths
blk-files: copy []

either collect-img > 0 [
    ; cls
    ; clean
    ; exif search
    foreach file blk-files [
        response: get-datetime-original file
        if first response [
            prin last split file "/"
            print response/2
        ]
    ]    

    print "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
    print "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
    print "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
    print "/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"

    print "The following files have errors"

    foreach file blk-files [
        response: get-datetime-original file
        ;probe response
        if not first response [
            prin last split file "/"
            prin " -> "
            print response/2
        ]
    ]
][
    print "Aucune image trouvée"
]

()
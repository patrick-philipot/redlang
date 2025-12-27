Red [ purpose: "List and search my program database with backup and input"]

; console history
last-history-command: last system/console/history

db: load %myprog.db

a-line: "------------------------------------------------------------LIST--"
b-line: "-----------------------------------------------------------NEW--"
d-line: "-------------------------------------------------------------DEL--"
e-line: "-----------------------------------------------------------EDIT--"

special-case: false

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

print-all: does [
    count: 0
    foreach item db [
        print a-line
        print [ "name : " item/1 ]
        print [ "what : " item/2 ]
        print [ "tags : " item/3 ]
        print [ "from : " item/4 ]
        count: count + 1
    ]
    print a-line
    print [ "Database contains " count "programs^/"]
] 

print-all-sorted: func [/local db2][
    db2: copy []
    foreach item db [ append db2 item/1 ]
    db2: sort db2
    print a-line
    foreach item db2 [ print item ]
    print a-line
    print [ "Database contains " length? db2 "programs^/"]
]

backup: func [ /local str-time back-name ][
    ; build a backup name from date as-is and time without second
    str-time: replace/all form now/time ":" "h"
    str-time: copy/part str-time find/last str-time "h"
    back-name: rejoin [ now/date "-" str-time ]
    return to-file append back-name ".db"
]


enter-record: func [ /edit item /local name what tags from confirm blk lines n][
    until [
        print either edit [ e-line ][ b-line ]
        print either edit ["Editing mode^/Up arrow to get previous value"]["Ready for a new-record"]
        print "Program name"
        either edit [ 
            name: ask/history  "name :" reduce [item/1]][
            name: ask "name :"
            ]
        if not find name ".red" [ name: rejoin [name ".red"]]
        
        print "What it does"
        either edit [
            what: ask/history  "what :" reduce [item/2]][
            what: ask "what :"
        ]

        print "Main Red commands used"
        either edit [
            tags: ask/history  "tags :" reduce [item/3]][
            tags: ask "tags :"
        ]
        print "Origine such as Rebol example or documentation"
        either edit [
           from: ask/history  "from :" reduce [item/4]][
           from: ask "from :"
        ]

        print either edit [e-line][b-line]
        
        print [ "name : " name ]
        print [ "what : " what ]
        print [ "tags : " tags ]
        print [ "from : " from ] 

        confirm: uppercase ask "Type Y to confirm, R to retry, other to abort : "
        switch/default confirm [
            "R" [ false ]
            "Y" [
                write backup db
                either edit [
                    item/1: name
                    item/2: what
                    item/3: tags
                    item/4: from
                    write %myprog.db db
                ][
                    lines: read/lines %myprog.db
                    n: back tail lines
                    blk: compose [ (to-string name) (to-string what) (to-string tags) (to-string from) ]
                    insert/only n blk
                    write/lines %myprog.db lines
                    append/only db blk
                ]
                true
            ]

        ][  ; default case
            true
        ]
    ]
]

del-record: func [ blk [block!]][
    print d-line
    print prog-name: blk/1
    print blk/2
    print blk/3
    print blk/4
    confirm: ask "Type Y to confirm deletion of this record: "
    either "Y" == uppercase confirm [
        write backup db
        remove-each entry db [ prog-name == first entry ]
        write %myprog.db db
        print "------RECORD DELETED-------"
    ][
        print "-----deletion-aborted------"
    ]
    ask "Press a key to continue"
]

; program starts here

print "Here are the programs in the database"
print a-line
foreach item db [print item/1]
print a-line

; main loop   
forever [
    prin "Search by tag or name"
    print "(part of name or tags will perform search)"
    print "Type 'all' for a complete database listing."
    print "Type 'sort' for a sorted database listing."
    print "Type 'new' to create a new record."
    print "Type 'program name' including '.red' to display it in full"
    print "Press [Enter] to quit.^/"
    answer: ask {Enter tag, name, or command ?  }
    print newline
    switch/default answer [
        "all"   [ print-all]
        "sort"   [ print-all-sorted]
        ""      [ ask "Goodbye!  Press any key to end." clean() break ]
        "new"   [ do enter-record ] 
        ][ ;--- special-case to handle request made for the program name (.red)
        special-case: (copy/part tail answer -4) == ".red"
        found: false

        ; how many results and if any storing them

        blk-results: copy []
        index: 0
        foreach item db [
            index: index + 1
            if find rejoin [ item/1 " " item/3 ] answer [
                append blk-results index
            ]
        ]

        ; special-case extended to search having only one matched item

        if  1 == length? blk-results [ special-case: true ]

        either special-case [
            blk-search: [ item/1]
        ][
            blk-search: [ item/1 " " item/3 ]         
        ]

        foreach elem blk-results [
            item: db/:elem
            print a-line
            print item/1
            if special-case [
                special-item: item
                print item/2
                print item/3
                print item/4
            ]
            found: true
        ]

        either found <> true [
            print replace copy {Nothing found with "XXX" in the database!^/} "XXX" answer
        ][ print a-line ]
    ]

    ; different prompt for special-case
    either special-case [
        ; DELETE, EDIT, RUN can be done here
        print "Press [ENTER] to continue"
        print "Type DEL to delete "
        print "Type EDIT to modify "
        action: uppercase ask "Type RUN to execute? "
        if action == "DEL" [ del-record special-item ]
        if action == "EDIT" [ enter-record/edit special-item ]
        if action == "RUN" [ do load to-file special-item/1 ]
        special-case: false
    ][
        ask "Press [ENTER] to continue"
        clean()
    ]
]

; ending code
; clean up system/console/history
insert system/console/history last-history-command ()







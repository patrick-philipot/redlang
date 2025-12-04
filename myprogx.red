Red [ purpose: "List and search my program database with backup and input"]

db: load %myprog.db

a-line: "-----------------------------------------------------------------"
b-line: "+++++++++++++++++++++++++++++++++++++++++++++++"

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


new-record: func [ /local name what tags from confirm blk lines n][
    until [
        print b-line
        print "Ready for a new-record ?"
        print "Program name"
        name: ask "name :"
        print "What it does"
        what: ask "what :"
        print "Main Red commands used"
        tags: ask "tags :"
        print "Origine such as Rebol example or documentation"
        from: ask "from :"
        print a-line
        print [ "name : " name ]
        print [ "what : " what ]
        print [ "tags : " tags ]
        print [ "from : " from ] 
        confirm: ask "Type Y to confirm : "
        either "Y" == uppercase confirm [
            write backup db
            lines: read/lines %myprog.db
            n: back tail lines
            blk: compose [ (to-string name) (to-string what) (to-string tags) (to-string from) ]
            insert/only n blk
            write/lines %myprog.db lines
            append/only db blk
            true
        ][ false ]
    ]
]


; main loop   
forever [
    print "Here are the current program in the database:^/"
    print a-line
    foreach item db [print item/1]
    print "" print a-line
    prin "Search by tag or name"
    print "(part of name or tags will perform search)"
    print "Type 'all' for a complete database listing."
    print "Type 'new' to create a new record."
    print "Press [Enter] to quit.^/"
    answer: ask {Enter tag, name, or command ?  }
    print newline
    switch/default answer [
        "all"   [ print-all]
        "sort"   [ print-all-sorted]
        ""      [ ask "Goodbye!  Press any key to end." halt]
        "new"   [ do new-record ]       
        ][
        found: false
        foreach item db [
            if find rejoin [ item/1 " " item/3 ] answer [
                print a-line
                print item/1
                found: true
            ]
        ]
        either found <> true [
            print replace copy {Nothing found with "XXX" in the database!^/} "XXX" answer
        ][ print a-line ]
    ]
    ask "Press [ENTER] to continue"
]






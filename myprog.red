Red [ purpose: "List and search my program database"]

db: load %myprog.db

a-line: "-----------------------------------------------------------------"

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
forever [
    prin "^L"
    print "Here are the current program in the database:^/"
    print a-line
    foreach item db [print item/1]
    print "" print a-line
    prin "Search by tag or name"
    print "(part of name or tags will perform search):^/"
    print "Type 'all' for a complete database listing."
    print "Press [Enter] to quit.^/"
    answer: ask {What tag ?  }
    print newline
    switch/default answer [
        "all"     [print-all]
        ""         [ask "Goodbye!  Press any key to end." halt]
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






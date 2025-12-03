Rebol []
users: [
    ["John" "Smith" "123 Tomline Lane" "Forest Hills, NJ" "555-1234"]
    ["Paul" "Thompson" "234 Georgetown Pl." "Peanut Grove, AL" "555-2345"]
    ["Jim" "Persee" "345 Pickles Pike" "Orange Grove, FL" "555-3456"]
    ["George" "Jones" "456 Topforge Court" "Mountain Creek, CO" ""]
    ["Tim" "Paulson" "" "" "555-5678"]
]
a-line: copy [] loop 65 [append a-line "-"]
a-line: trim to-string a-line
print-all: does [
    foreach user users [
        print a-line
        print rejoin ["User:     " user/1 " " user/2]
        print a-line
        print rejoin ["Address:  " user/3 "  " user/4]
        print rejoin ["Phone:    " user/5]
        print newline
    ]
]    
forever [
    prin "^L"
    print "Here are the current users in the database:^/"
    print a-line
    foreach user users [prin rejoin [user/1 " " user/2 "  "]]
    print "" print a-line
    prin "Type the name of a user below "
    print "(part of a name will perform search):^/"
    print "Type 'all' for a complete database listing."
    print "Press [Enter] to quit.^/"
    answer: ask {What person would you like info about?  }
    print newline
    switch/default answer [
        "all"     [print-all]
        ""         [ask "Goodbye!  Press any key to end." halt]
        ][
        found: false
        foreach user users [
            if find rejoin [user/1 " " user/2] answer [
                print a-line
                print rejoin ["User:     " user/1 " " user/2]
                print a-line
                print rejoin ["Address:  " user/3 " " user/4]
                print rejoin ["Phone:    " user/5]
                print newline
                found: true
            ]
        ]
        if found <> true [
            print "That user is not in the database!^/"
        ]
    ]
    ask "Press [ENTER] to continue"
]
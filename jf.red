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
] ; clean

alert: func [ message [string!] ][
    blk: compose [
        title "Recherche d'images pour LightRoom"
        text (message) return
        button "OK" [ unview ]  
    ]
    view/flags layout blk [popup]
]


; /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ 
image-search: func [][

    affiche-rep: func [p1 [string!] /local result ][
        foreach [f1 f2] folder-list [ if f1 == p1 [ result: f2]] 
        result
    ]

    forever [
        ; refresh console
        print "Recherche d'une image, saisir le nom complet ou partiel"
        prin "(laisser vide pour terminer) "
        answer: ask {Votre recherche ?  }
        switch/default answer [
            ""      [ ask "Goodbye!  Press any key to end." clean() break ]
            ][ 
            pic: answer
            foreach item found-list [
                if find item pic [ 
                    dir: first split item "|"
                    image: second split item "|"
                    print compose [ "Image " (image) " trouvée dans le dossier ^/" (affiche-rep dir) newline ]
                ]
            ]
            ; ask ">>> Enter pour continuer"
            ; clean
        ]
    ]
] ; lookup


lookup: func [][

    recurse: func [current-folder] [ 
        ; compteur
        count: add count 1
        ; en string
        folder: to-string reduce [ "F" count]

        print what-dir
        ; append found-list what-dir
        append folder-list folder
        append folder-list what-dir
        foreach item (read current-folder) [ 
            ; handle 2 or 3 letters extensions 
            if all [not dir? item find text-extensions find/last item "."][

                    print [item]
                    append found-list to-string reduce [folder "|" item]
                    ; append found-list item
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
    ] ; recurse

    ; saving current-dir
    init-dir: what-dir

    alert "Dans la fenêtre suivante, sélectionnez un répertoire à explorer"

    start-folder: request-dir/title "Folder to Start In:"

    found-list: copy []
    folder-list: copy []

    text-extensions: [ %.jpg %.jpeg %.png ] ; no need to use uppercase version

    print rejoin [{SEARCHING for JPEG in } start-folder "...^/"]
    change-dir start-folder

    ; compteur de répertoire
    count: 0
    recurse %./

    ; restoring init-dir
    change-dir init-dir

    foreach item found-list [ print item ] 
    foreach [f1 f2] folder-list [ print [f1 " = " f2 ]] 

] ; lookup

save-db: func [ f [file!]][
    db-block: copy []
    append/only db-block folder-list
    append/only db-block found-list
    if error? try [ write f db-block ] [ print "La sauvegarde a échoué" ]
]

sauve-db: func [/local name filename confirm][
    clean
    print "La sauvegarde sera réalisée dans le répertoire en cours"
    print what-dir
    print "^/Saisir un nom composé uniquement de lettres et de chiffres"
    print "l'extension .db sera automatiquement ajoutée^/"
    name: ask "Entrez un nom sans ponctuation ni extension : "
    append name ".db"
    filename: to-file name
    either exists? filename [
        print "Erreur: ce nom de fichier est déjà utilisé"
        print "Par sécurité, ce programme s'interdit toute suppression de fichiers"
        print "La sauvegarde n'a pas été réalisée"
    ][
        print reduce ["Confirmez-vous la création du fichier " filename ]
        confirm: uppercase ask "Tapez OUI pour confirmer "
        either confirm == "OUI" [
            save-db filename
        ][
            print "La sauvegarde n'a pas été réalisée"
        ]
    ]
] ; sauve-db

charge-db: func [/local db-file db][

    alert "Dans la fenêtre suivante, sélectionnez la sauvegarde"

    db-file: request-file/title  "Sélection d'une sauvegarde"

    db: load db-file

    ; check if it looks like a genuine db

    either all [ block! == type? first db block! == type? second db "F1" == first first db ] [
        found-list: copy second db
        folder-list: copy first db
        print "La sauvegarde a bien été chargée"
    ][
        print "Erreur^/Le fichier chargé n'est pas une sauvegarde valide"
        found-list: copy []
        folder-list: copy []
    ]
] ; charge-db

; /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MAIN
;

; menu

forever [

    clean
    print "/\/\/\/\/\/\/\/\/\ Recherche d'images pour LightRoom /\/\/\/\/\/\/\/\/\"
    print "Entrez votre choix"
    print "E -> Explorer un répertoire"
    print "S -> Sauver votre recherche sur le disque"
    print "C -> Charger une recherche préalablement sauvée"
    print "R -> Rechercher une image dans la recherche en cours"
    print "Q -> Quitter le programme"

    answer: ask {Taper votre choix puis ENTER > }
    print newline
    switch/default uppercase answer [

        "E" [ 
                lookup 
                ; print found-list
                print [ length? found-list " image(s) trouvée(s) dans " 
                        length? folder-list " répertoire(s)" 
            ]
] 
        "S" [   
                either 0 <> length? found-list [
                    sauve-db
                ][
                    print "Erreur: il n'y a pas de recherche en cours"
                ]
            ] 
        "C" [ charge-db ]
        "R" [ 
                image-search 
            ] 
        "Q" [ halt ]

    ][
        print [ uppercase answer " choix non disponible"]
    ]

    print newline
    print "Cliquer pour activer la fenêtre si nécessaire"
    ask "puis Enter pour revenir au menu"

]





; main loop   
;clean

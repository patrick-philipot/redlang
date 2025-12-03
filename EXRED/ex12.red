Red [needs: 'view]
view [
    title "ex12"
    below
    f: field "Enter some lines here..."
    button "Save" [
        save %mylist.txt append append load %mylist.txt f/text "^M^/"
        print "Saved"
    ]
    a: area "All log entries will appear here when loaded..."
    button "Load" [
        a/text: form load %mylist.txt
    ]
]

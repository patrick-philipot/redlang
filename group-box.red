 Red [
    needs: 'view
    from: { http://www.mycode4fun.co.uk/red-beginners-reference-guide
            ;;Here we use:    'style'    'group-box'    'reduce'    'origin'     'attempt' }
 ]

view [
    style txt: text                                                         ;; <-- sets a new style.
    
    group-box "My Group Box" 1  [
        origin 40x40         ;; <-- start of group-box and size it.
        txt "Name" name: field 200
        txt "Address1" addrs1: field 200
        txt "Address2" addrs2: field 200

        button "save" [
            save %mygroupbox.txt reduce [name/text addrs1/text addrs2/text ] 
            t/text: "*Saved*"
        ] 

        button "load" [
            attempt [set [nm ad1 ad2]  load %mygroupbox.txt]  
            attempt [name/text: nm] 
            attempt [addrs1/text: ad1]  
            attempt [addrs2/text: ad2]  
            t/text: " *Loaded* "
        ] 


        t: text font-size 16 font-color red "                "
    ]
 ]
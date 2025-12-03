Red [title: "Origin, tab panel, slider, progress, base" needs: 'view]
view [
    origin 0x0 space 0x0
    tab-panel 500x500 [
        "Tab 1    " [
            below
            progress 100x20 data 20% react [face/data: s/data]
            text " Use slider to change progress-bar"
            s: slider 100x20 data 20%

            text red " across do not work here "
        ]
        "Tab 2    " [
            base 400x400 draw [
                pen red 
                circle 75x100 30
            ]
        ]
    ]
]

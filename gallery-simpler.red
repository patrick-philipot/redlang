Red [
    title: "Basic image gallery"
    what: "Image gallery"
    tag: "(stylize vh2 vh3 space) style compose/deep/only origin set to-word get to-set-word to-point2D"
    from: "https://stackoverflow.com/questions/1252561/how-to-cope-with-rebol-events-when-the-layout-is-built-programmatically"
]

thumb-width: 150; width of the thumbnails
thumbs-per-row: 6   ; number of thumbs per row

; clicking/left action on thumb
full-size: func[ img [image!]][view layout [ image img ]]
thumb-action: [ full-size face/image ]


; samples images
imgs: [
    %./cats/cat-1.jpg
    %./cats/cat-2.jpg
    %./cats/cat-3.jpg
    %./cats/cat-4.jpg
]

; gallery layout
gallery-lay: copy compose/deep/only [
    title "Red Image gallery"
    origin 2x2 
    style thumb: base on-down (thumb-action)
    across
    h2 "Image gallery"
]

; Builds the final layout
count: 0
foreach img imgs [
    ; This for handling only a defined number of thumbs per row
    if 0 = (count // thumbs-per-row) [append gallery-lay 'return]
    count: count + 1
    ; Get image width
    image: load img 
    image-width: image/size/1
    ; ratio for resizing image to the thumb size
    ratio: thumb-width / image-width
    ; Red can use point2D instead of pair
    append gallery-lay compose [ thumb (to-point2D image/size * ratio) (img) ]   
]

; for debug 
probe gallery-lay

; main window
view layout gallery-lay 


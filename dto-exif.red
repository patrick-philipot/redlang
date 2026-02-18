Red[
    what: "reading datetime/original EXIF tag" 
    tag: "datetime-original"
    from: "Sensei, and documentation"
    ref: "https://en.wikipedia.org/wiki/JPEG_File_Interchange_Format"
]

errors: context [
    reading-file: does [ reduce [false  "Error reading file"]]
    no-exif-found: does [ reduce [false "No EXIF Header"]]
    invalid-tag: does [ reduce [false   "Incorrect tag"]]
    no-tag-found: does [ reduce [false  "tag not found"]]
]

read-exif: function [file [file!] /debug ][
    if error? try [ data: read/binary file ][ return errors/reading-file ]
    ; Find APP1 marker (EXIF segment)
    unless parse data [
        #{FFD8}                          ; JPEG SOI
        thru #{FFE1}                     ; APP1 marker
        copy seg-len 2 skip              ; Segment length
        "Exif" 2 skip                    ; EXIF header
        copy tiff-header to end          ; Rest is TIFF data
    ][
        return errors/no-exif-found
    ]

    ; length of the exif-data ( always in big indian format)
    bytes-count: to-integer seg-len
    if debug [? seg-len]
    
    ; Return raw TIFF data for further parsing starting with #{4D4D} or #{4949}
    data: copy/part tiff-header bytes-count

    ; hexdump starting usually at #{000c}
    if debug [
        print ["Exif for " to-string file]
        repeat n 40 [
            skipper: ( n - 1) * 16
            hex-string: to-string to-hex ( 12 + ((n - 1) * 16))
            print compose/deep [ skip hex-string 4 "  " copy/part skip data skipper 16 (tab) (n * 16) ]
        ]
        print ["Exif for " to-string file]
    ]
    data
]

check-valid-tagdata: function [ bin [binary!] indianness [logic!]][
    ; true -> little-endian
    either indianness [
        expected-value: #{0390020014000000}
    ][
        expected-value: #{9003000200000014}
    ]
    return expected-value == copy/part bin 8
]

handle-error: function [ message [string!] explicit [logic!]][
    return either explicit [message][""]
]

get-datetime-original: function [ file [file!] /debug ][
    either debug [
        exif-data: read-exif/debug file
    ][
        exif-data: read-exif file
    ]

    either block! == type? exif-data [
            ; returns the error block
            return exif-data
        ][
        ; Check byte order (II = little-endian, MM = big-endian)
        byte-order: copy/part exif-data 2
        little?: byte-order == #{4949}
        if debug [
            print either little? ["little indian"]["big indian"]
            ? little?
        ]

        ; datetime-original tag (value differs with indianness)
        ;tag: either little? [reverse #{9003}][#{9003}]
        tag: either little? [reverse copy #{9003}][#{9003}]
        if debug [ ? tag ]
        either tag-data: find exif-data tag [
            if debug [ ? tag-data ]
            tag-datetime-original: copy/part tag-data 20
            ; check if tag is valid
            ; Big indian ->     9003000200000014
            ; Little indian ->  0390020014000000
            unless check-valid-tagdata copy/part tag-datetime-original 8 little? [
                return errors/invalid-tag
            ]
            if debug [ print copy/part tag-datetime-original 20 ]
            ;Each of the 12-byte field entry consists of the following four elements respectively.
            ;Bytes 0-1 Tag
            ;Bytes 2-3 Type
            ;Bytes 4-7 Count
            ;Bytes 8-11 Value Offset
            ; Offset is relative to the starting byte of the tag (byte O)

            offset-bytes: copy/part skip tag-datetime-original 8 4
            if debug [ ? offset-bytes ]
            ;(value differs with indianness)
            offset: to-integer either little? [ reverse offset-bytes ][ offset-bytes ]
            if debug [ ? offset ]
            ; datetime-original in ASCII values (not affected by indianness) 
            return reduce [ true to-string ascii-datetime: copy/part skip exif-data offset 19 ]  ; 20 - 1 = 19, 20th is NULL
        ][
            return errors/no-tag-found
        ]
    ]        
]

; for testing
if true [
    probe get-datetime-original %./EXIF-TEST/non-exist-file.jpg
    probe get-datetime-original %./EXIF-TEST/II.jpg
    probe get-datetime-original %./EXIF-TEST/MM.jpg
    probe get-datetime-original %./EXIF-TEST/NOEXIF.jpg
    probe get-datetime-original %./EXIF-TEST/FC-pose-isolant.jpg
    print get-datetime-original %./EXIF-TEST/II.jpg
    print get-datetime-original %./EXIF-TEST/MM.jpg
    print get-datetime-original %./EXIF-TEST/NOEXIF.jpg
]
()



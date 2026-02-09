Red [
    what: "display exif/datetime-original of a given image"
    from: "Senseï"
]

little?: false

read-exif: function [file [file!]][
    data: read/binary file
    
    ; Find APP1 marker (EXIF segment)
    unless parse data [
        #{FFD8}                          ; JPEG SOI
        thru #{FFE1}                     ; APP1 marker
        copy seg-len 2 skip              ; Segment length
        "Exif" 2 skip                    ; EXIF header
        copy tiff-header to end          ; Rest is TIFF data
    ][
        return "No EXIF found"
    ]
    
    ; Check byte order (II = little-endian, MM = big-endian)
    byte-order: copy/part tiff-header 2
    little?: byte-order = "II"
    
    ; Return raw TIFF data for further parsing
    tiff-header
]

; Usage:
image-file: %2252.jpg
exif-data: read-exif image-file
tag-datetime: copy/part find exif-data #{9003} 20

;Each of the 12-byte field entry consists of the following four elements respectively.
;Bytes 0-1 Tag
;Bytes 2-3 Type
;Bytes 4-7 Count
;Bytes 8-11 Value Offset

offset: to-integer skip tag-datetime 8

ascii-datetime: copy/part skip exif-data offset 19   ; 20 - 1 = 19, 20th is NULL

prin [ image-file " >> " ]
prin [ either little? ["(little"]["(big"] "-indian) " ]
print compose [ "datetime-original " to-string ascii-datetime ]

; extra

; EXIF data starts after FFE1 marker in JPEG files
; Common tag IDs:
; 33434 = Exposure time
; 33437 = F-number  
; 34855 = ISO speed
; 36867 = Date/time original
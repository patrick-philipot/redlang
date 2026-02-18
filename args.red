#!/opt/red-view
Red []
; used command line :
; ./args.red L1014654.jpg
; or
; ./args.red "L1014654.jpg"
; with identical results

; args: system/script/args
args: system/options/args
print ["Received arguments:" args]
filename: args/1

print reduce [ filename " is of type " type? filename ]
print reduce [ "first of filename " first filename ]
print reduce [ "last of filename " last filename ]
print reduce [ "length of filename " length? filename ]
print "probe of filename shows " probe filename 
db: [
		[ "aa" "bb" "cc" "dd" ]
		[ "11" "22" "33" "44" ]
		[ "xx" "yy" "zz" "00" ]
]

mod-rec: func [ item ] [

	print "Changing"
	print item/1
	print item/2
	print item/3
	print item/4

	name: what: tags: from: "changed"

	blk: compose [ (to-string name) (to-string what) (to-string tags) (to-string from) ]

	item/1: name
	item/2: what
	item/3: tags
	item/4: from


]

item: db/2
mod-rec item
probe db


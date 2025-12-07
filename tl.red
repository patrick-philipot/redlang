Red []
view layout [
	text-list 100x100 data ["adam" "bernard" "camille"] [
		print [ "selected^(tab)>> "    face/selected]
		print [ "value^(tab)^(tab)>> " pick face/data face/selected]

	]
]
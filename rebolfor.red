Red[purpose: "understanding REBOL for"]

for: func [
    "Repeats a block over a range of values." 
;    [catch throw] 
    'word [word!] "Variable to hold current value" 
    start [number! series! money! time! date! char!] "Starting value" 
    end [number! series! money! time! date! char!] "Ending value" 
    bump [number! money! time! char!] "Amount to skip each time" 
    body [block!] "Block to evaluate" 
    /local result do-body op
][
    if (type? start) <> (type? end) [
        throw make error! reduce ['script 'expect-arg 'for 'end type? start]
    ] 
    ;?? body
    do-body: func reduce [[throw] word] body 
    ;?? do-body
    op: :greater-or-equal? 
    either series? start [
        if not same? head start head end [
            throw make error! reduce ['script 'invalid-arg end]
        ] 
        if (negative? bump) [op: :lesser?] 
        while [op index? end index? start] [
            set/any 'result do-body start 
            start: skip start bump
        ] 
        if (negative? bump) [set/any 'result do-body start]
    ] [
        if (negative? bump) [op: :lesser-or-equal?] 
        while [op end start] [
            set/any 'result do-body start 
            start: start + bump
        ]
    ] 
    get/any 'result
]


print {for n 1 15 2 [ prin space prin n ] print []}
for n 1 15 2 [ prin space prin n ] print []

print {for n 15 1 -2 [ prin space prin n ] print []}
for n 15 1 -2 [ prin space prin n ] print []

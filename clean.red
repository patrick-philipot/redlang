Red[ what: { dockimbel answer for simulating CTRL+L : Assuming you are implying the Red GUI console, here is a quick and dirty function to programmatically achieve console output clearing}]

clean: does [
  do bind [
    full?:      no
    top:        1
    scroll-y:   0
    line-y:     0
    line-cnt:   0
    screen-cnt: 0
    line-pos:   1
    clear lines
    clear nlines
    clear heights
    clear selects
    gui-console-ctx/scroller/page-size: page-cnt
    gui-console-ctx/scroller/max-size: page-cnt - 1
    gui-console-ctx/scroller/position: 0
  ] gui-console-ctx/terminal
  system/view/platform/redraw gui-console-ctx/console
]

view [
  button "Print Hello" [print "Hello!"]
  button "clean" [clean]
]
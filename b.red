Red[ needs: 'view ]
bye-button-clicked: function[] [
    text-message/text: "Goodbye!"
]

view [
    bye-button: button "Press Me" [bye-button-clicked]
    text-message: text yellow "Hello!"
]
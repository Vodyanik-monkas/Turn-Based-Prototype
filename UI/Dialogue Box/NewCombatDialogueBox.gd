extends HBoxContainer

var options = [
	{
		"id": "attack", 
		"tooltip": "A basic physical attack. MP:3"
	}, 
	{
		"id": "defend",
		"tooltip": "This option is brought to you by a rock."
	},
	{
		"id": "piss",
		"tooltip": "Only a natural response when considering getting your guts spilled across the pavement. MP: 100%"
	}
]

func _ready():
	$ToolTipBox/MarginContainer/OptionMenu.initialize_option_menu(options)


func _on_OptionMenu_update_tooltip(index):
	$ToolTip.set_tooltip(options[index]["tooltip"])

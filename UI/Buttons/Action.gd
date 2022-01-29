extends HBoxContainer

var namaewa = "name"
var active = false

func _ready():
	$Label.text = namaewa

func active():
	active = true
	$Selected.show()

func inactive():
	active = false
	$Selected.hide()

func toggle_active():
	active = not active
	if active:
		$Selected.show()
	else:
		$Selected.hide()

extends PopupDialog


signal cash_out


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Sus_pressed():
	emit_signal("cash_out")

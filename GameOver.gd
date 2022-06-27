extends Control


onready var total_profit_label = $VBoxContainer/HBoxContainer/MoneyBoard3/AllProfit


# Called when the node enters the scene tree for the first time.
func _ready():
	total_profit_label.text = str(Autoload.total_profit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGameButton_pressed():
	Autoload.money = 10
	Autoload.suspicion = 0
	Autoload.previous_money = 10
	Autoload.total_profit = 0
	get_tree().change_scene("res://Main.tscn")

extends Control


var profit

onready var money_label = $VBoxContainer/MoneyBoard/Calculations/Panel/VBoxContainer/Money
onready var prev_money_label = $VBoxContainer/MoneyBoard/Calculations/Panel/VBoxContainer/PrevMoney
onready var profit_label = $VBoxContainer/MoneyBoard/Result/ColorRect/Profit


func _ready():
	profit = Autoload.money - Autoload.previous_money
	profit_label.text = str(profit)
	prev_money_label.text = str(Autoload.previous_money)
	money_label.text = str(Autoload.money)


func _on_NewGameButton_pressed():
	Autoload.previous_money = Autoload.money
	Autoload.total_profit += profit
	get_tree().change_scene("res://Main.tscn")

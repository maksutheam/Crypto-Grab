extends Control


onready var ui_money = $HBoxContainer/Stats/Stuff/HBoxContainer/Money/Amount
onready var ui_suspicion = $HBoxContainer/Stats/Stuff/HBoxContainer/Suspicion/Amount
onready var ui_coins = $HBoxContainer/Stats/Stuff/HBoxContainer/Coins/Amount
onready var ui_coin_bar = $HBoxContainer/Stats/Value/Lines/ProgressBar
onready var ui_price_crash = $HBoxContainer/Stats/Value/Lines/Panel/VBoxContainer/Crash
onready var ui_coin_value = $HBoxContainer/Stats/Value/Lines/Panel/VBoxContainer/Value
onready var sus_dialogue = $SusDialogue
onready var sus_dialogue2 = $SusDialogue2
onready var sus_rect = $ColorRect

export var max_suspicion = 100

var turn = 0

var coins = 0
var coin_value = 0

var turns_to_crash = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_price_crash.hide()
	randomize()
	turn = 0
	coins = 5
	coin_value = 1
	turns_to_crash = randi() % 10 + 3

func _process(_delta):
	ui_suspicion.text = str(Autoload.suspicion)
	ui_money.text = str(Autoload.money)
	ui_coins.text = str(coins)
	ui_coin_bar.value = coin_value
	ui_coin_value.text = str(coin_value)

func next_turn(coin_value_add):
	randomize()
	var rand_int = (randi() % max_suspicion + 1)
	var new_coin_value = coin_value + (coin_value_add + round(rand_range(-2, 1)))
	if Autoload.suspicion <= rand_int:
		print_debug(rand_int, " et menny vankilaan")
	else:
		print_debug(rand_int, " menit vankilaan")
		if Autoload.suspicion <= 10:
			pass
		elif Autoload.suspicion <= 25:
			sus_dialogue.popup() #Maksa sakko
		elif Autoload.suspicion <= 50:
			sus_dialogue2.popup() #Lopeta kolikko
		elif Autoload.suspicion <= 100:
			get_tree().change_scene("res://GameOver.tscn") #Game Over
		else:
			pass
	
	if turn >= turns_to_crash:
		ui_price_crash.show()
		coin_value -= 3
		print_debug("hups! ", turns_to_crash)
	else:
		if new_coin_value <= 0:
			coin_value = 0
		else:
			coin_value = new_coin_value
	print_debug(coin_value)
	
	if (Autoload.suspicion - 1) > 0:
		Autoload.suspicion -= 1
	
	turn += 1

func cash_out():
	Autoload.money += coins * coin_value
	coins = 0
	get_tree().change_scene("res://CashOut.tscn")

func _on_Coin_pressed():
	if coins > 0:
		Autoload.money += 1 * coin_value
		coins -= 1
		next_turn(0)
	else:
		pass


func _on_Promise_pressed():
	Autoload.suspicion += 2
	next_turn(1)


func _on_Collab_pressed():
	if (Autoload.money - 3) >= 0 and (coins - 1) > 0:
		Autoload.money -= 3
		coins -= 1
		Autoload.suspicion += 2
		next_turn(3)
	else:
		pass


func _on_Hack_pressed():
	Autoload.suspicion += 5
	next_turn(2)


func _on_CashOut_pressed():
	cash_out()


func _on_Mine_pressed():
	coins += 1
	next_turn(0)


func _on_SusDialogue2_cash_out():
	cash_out()

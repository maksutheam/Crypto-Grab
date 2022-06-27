extends PopupDialog


export var money_lost = 11
export var suspicion_get = 6

onready var money_button = $VBoxContainer/HBoxContainer/Money
onready var sus_button = $VBoxContainer/HBoxContainer/Sus

# Called when the node enters the scene tree for the first time.
func _ready():
	var money_text = "- %s Money"
	var sus_text = "+ %s Suspicion"
	money_button.text = money_text % money_lost
	sus_button.text = sus_text % suspicion_get


func _on_Money_pressed():
	Autoload.money -= money_lost
	print_debug(Autoload.money)
	hide()


func _on_Sus_pressed():
	Autoload.suspicion += suspicion_get
	print_debug(Autoload.suspicion)
	hide()

func _on_SusDialogue_about_to_show():
	randomize()
	money_lost = floor(rand_range(1, 50))
	suspicion_get = floor(rand_range(1, 15))
	
	var money_text = "- %s Money"
	var sus_text = "+ %s Suspicion"
	money_button.text = money_text % money_lost
	sus_button.text = sus_text % suspicion_get

extends Node2D
var Macka_Hp = 40
var Gracz_Hp = 100
var Mob_attack = 0
var Mob_stun = 0
var Boost = 0
var atak = RandomNumberGenerator.new()
var heal = RandomNumberGenerator.new()
func _ready():
	get_node("Hood/Attack").connect("pressed", self, "_on_Attack_pressed")
	get_node("Hood/Stun").connect("pressed", self, "_on_Stun_pressed")
	get_node("Hood/Boost").connect("pressed", self, "_on_Boost_pressed")
	get_node("Hood/Heal").connect("pressed", self, "_on_Heal_pressed")
	
func _process(delta):
	get_node("Gracz_Hp").text = String(Gracz_Hp) + "/100"
	get_node("Enemy_Hp").text = String(Macka_Hp) + "/40"
	if Macka_Hp < 1:
		get_tree().change_scene("res://Win.tscn")
	if Gracz_Hp < 1:
		get_tree().change_scene("res://lose.tscn")
	if Mob_attack == 1 and Mob_stun == 0:
		atak.randomize()
		heal.randomize()
		Mob_attack = 0
		if Macka_Hp < 20:
			Macka_Hp +=  heal.randi_range(6,15)
		else:
			Gracz_Hp -= atak.randi_range(10,30)
	elif Mob_attack == 1 and Mob_stun == 1:
		Mob_stun = 0
		Mob_attack = 0
	
func _on_Attack_pressed():
	atak.randomize()
	if Boost == 1:
		Macka_Hp -= atak.randi_range(15,20)
	else:
		Macka_Hp -= atak.randi_range(8,11)
	Mob_attack = 1

func _on_Stun_pressed():
	Macka_Hp -= 3
	Mob_stun = 1
	Mob_attack = 1
func _on_Boost_pressed():
	Boost = 1
	Mob_attack = 1


func _on_Heal_pressed():
	heal.randomize()
	Gracz_Hp += heal.randi_range(10,25)
	if Gracz_Hp > 100:
		Gracz_Hp = 100	
	Mob_attack = 1

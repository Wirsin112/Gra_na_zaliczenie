extends Node2D
var Gracz
var save_path_Gracz = "user://hp.dat"
var start_set = [100,100,100,0,200]

func _ready():
	load_data() 
	$Sprite/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
	$Sprite/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
	$Sprite/Gracz/Hp.max_value = Gracz[1]
	$Sprite/Gracz/Food.max_value = 100
	$Sprite/Gracz/Hp.value = Gracz[0]
	$Sprite/Gracz/Food.value = Gracz[2]
	
func save_data(save):
	var file = File.new()
	var error = file.open(save_path_Gracz, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(save_path_Gracz):
		var error = file.open(save_path_Gracz, File.READ)
		if error == OK:
			Gracz = file.get_var()
			file.close()
func set_hp_food():
	if Gracz[0] <= 0:
		get_tree().change_scene("res://Death.tscn")
	else:
		$Sprite/Gracz/Hp.value = Gracz[0]
		$Sprite/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
		$Sprite/Gracz/Food.value = Gracz[2]
		$Sprite/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
		save_data(Gracz)


func _on_Button_pressed():
	if Gracz[2]-20 < 0:
		Gracz[0] -= (20-Gracz[2])
		Gracz[2] = 0
	else:
		Gracz[2] -= 20
		if Gracz[0]+10>=Gracz[1]:
			Gracz[0] = Gracz[1]
		else:	
			Gracz[0] += 10
	set_hp_food()


func _on_Exit_pressed():
	get_tree().change_scene("res://Main_Statek.tscn")

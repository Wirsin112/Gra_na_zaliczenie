extends Node2D
var save_path_Gracz = "user://hp.dat"
var save_path_is_saved = "user://is_saved.dat"
var Save = 1
var Nawigacja_check = 0
var Drzwi_check = 0
var Lozko_check = 0
var Plakat_check = 0
var Skrzynia_check = 0
var Krafting_check = 0
var Kuchenka_check = 0
var start_set = [100,100,100,0,200]
var Gracz
var hp_max = 100
var Food_max = 100
var LO
var licz = 0
func _ready():
	check_save() 
	$Sprite/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
	$Sprite/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
	$Sprite/Gracz/Hp.max_value = Gracz[1]
	$Sprite/Gracz/Food.max_value = 100
	$Sprite/Gracz/Hp.value = Gracz[0]
	$Sprite/Gracz/Food.value = Gracz[2]
	check_save()
	set_hp_food()
	save_unique(Save,save_path_is_saved)

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Nawigacja_check == 1:
		get_tree().change_scene("res://Planeta.tscn")
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Lozko_check == 1:
		get_tree().change_scene("res://Sen.tscn")
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Plakat_check == 1:
		get_tree().change_scene("res://Armor.tscn")
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Kuchenka_check == 1:
		get_tree().change_scene("res://Cooking.tscn")
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Skrzynia_check == 1:
		get_tree().change_scene("res://Skrzynia.tscn")
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Krafting_check == 1:
		get_tree().change_scene("res://Craftingv2.tscn")	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and Drzwi_check == 1:
		get_tree().change_scene("res://Skrzynia_wyprawa.tscn")	
		
func _on_Plakat_mouse_entered():
		Plakat_check = 1
func _on_Plakat_mouse_exited():
		Plakat_check = 0

func _on_Nawigacja_mouse_entered():
	Nawigacja_check = 1
func _on_Nawigacja_mouse_exited():
	Nawigacja_check = 0

func _on_Drzwi_mouse_entered():
	Drzwi_check = 1
func _on_Drzwi_mouse_exited():
	Drzwi_check = 0

func _on_lozko_mouse_entered():
	Lozko_check = 1
func _on_lozko_mouse_exited():
	Lozko_check = 0

func _on_Krafting_mouse_entered():
	Krafting_check = 1
func _on_Krafting_mouse_exited():
	Krafting_check = 0

func _on_Kuchenka_mouse_entered():
	Kuchenka_check = 1
func _on_Kuchenka_mouse_exited():
	Kuchenka_check = 0

func _on_Skrzynka_mouse_entered():
	Skrzynia_check = 1
func _on_Skrzynka_mouse_exited():
	Skrzynia_check = 0
	
func save_unique(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
			
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

func check_save():
	var file = File.new()
	if file.file_exists(save_path_Gracz):
		var error = file.open(save_path_Gracz, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path_Gracz, File.WRITE)
		if error == OK:
			file.store_var(start_set)
			file.close()
	load_data()
func set_hp_food():
	if Gracz[0] <= 0:
		Gracz[0] = 100
		Gracz[1] = 100
		save_data(Gracz)
		get_tree().change_scene("res://Death.tscn")
	else:
		$Sprite/Gracz/Hp.value = Gracz[0]
		$Sprite/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
		$Sprite/Gracz/Food.value = Gracz[2]
		$Sprite/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
		save_data(Gracz)

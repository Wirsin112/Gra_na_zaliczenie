extends Node2D
var save_path_planet = "user://Planet.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var start_set = [0,"Trawa","Woda"]
var start_set_curent = ["Ogien",0]
var curent
var planeta
var los
var lewa_prawa
var radar = 1;
func _ready():
	check_save()
	check_save_curent()
	if planeta[0] == 0:
		$Sprite/Exit.disabled = 1
		$Sprite/Exit.visible = 0
		$Sprite/Warning.rect_position = Vector2(-640,-360)
		$Sprite/Warning/W/blad.text = "Musisz wyruszyc na choc jedna wyprawe przed zmiana planety"
		$Sprite/Warning/W/Button.text = "Wroc do Statku"
		load_planets()
	else:
		if curent[1] >= 3:
			if radar == 1:
				$Sprite/Planet_left/Label.text = "Boss"
				$Sprite/Planet_right/Label.text = "Boss"
			$Sprite/Planet_left.texture_normal = load("res://Planet/Prad.png")
			$Sprite/Planet_right.texture_normal = load("res://Planet/Prad.png")	
			
		else:
			if radar == 1:
				_ustaw_opis()
				load_planets()
func _on_Exit_pressed():
		get_tree().change_scene("res://Main_Statek.tscn")
	
		
func save_data(save):
	var file = File.new()
	var error = file.open(save_path_planet, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
func save_curent(save):
	var file = File.new()
	var error = file.open(save_path_planet_curent, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	
func load_data():
	var file = File.new()
	if file.file_exists(save_path_planet):
		var error = file.open(save_path_planet, File.READ)
		if error == OK:
			planeta = file.get_var()
			file.close()
func load_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ)
		if error == OK:
			curent = file.get_var()
			file.close()
func check_save():
	var file = File.new()
	if file.file_exists(save_path_planet):
		var error = file.open(save_path_planet, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path_planet, File.WRITE)
		if error == OK:
			file.store_var(start_set)
			file.close()
	load_data()
	
func check_save_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set_curent)
			file.close()
	else:
		var error = file.open(save_path_planet_curent, File.WRITE)
		if error == OK:
			file.store_var(start_set_curent)
			file.close()
	load_curent()
func load_planets():
	$Sprite/Planet_left.texture_normal = load("res://Planet/"+String(planeta[1])+".png")
	$Sprite/Planet_right.texture_normal = load("res://Planet/" + String(planeta[2]) + ".png")
func _on_Button_pressed():
	get_tree().change_scene("res://Main_Statek.tscn")
func _zmien_planety():
	los = randi()%4
	if los == 0:
		planeta[1] = "Ogien"
	elif los == 1:
		planeta[1] = "Trawa"
	elif los == 2:
		planeta[1] = "Woda"
	elif los == 3:
		planeta[1] = "Prad"
	los = randi()%4
	if los == 0:
		planeta[2] = "Ogien"
	elif los == 1:
		planeta[2] = "Trawa"
	elif los == 2:
		planeta[2] = "Woda"
	elif los == 3:
		planeta[2] = "Prad"
func _on_Nie_pressed():
	$Sprite/ChosePlanet.rect_position = Vector2(640,-360)
func _on_Tak_pressed():
	$Sprite/ChosePlanet.rect_position = Vector2(640,-360)
	$Sprite/Warning.rect_position = Vector2(-640,-360)
	$Sprite/Warning/W/blad.text = "Wyrusz na przynajmniej jedna wyprawe by zmienic planete na nastepna"
	$Sprite/Warning/W/Button.text = "Wroc do Statku"
	planeta[0] = 0
	_ustaw_planete()
	_zmien_planety()
	save_data(planeta)
func _ustaw_planete():
	if lewa_prawa == 0:
		curent[0] = planeta[1]
		curent[1] += 1
		save_curent(curent)
	else:
		curent[0] = planeta[2]
		curent[1] += 1
		save_curent(curent)

func _on_Planet_left_pressed():
	$Sprite/ChosePlanet.rect_position = Vector2(-640,-360)
	lewa_prawa = 0

func _on_Planet_right_pressed():
	$Sprite/ChosePlanet.rect_position = Vector2(-640,-360)
	lewa_prawa = 1
func _ustaw_opis():
	if planeta[1] == "Ogien":
		$Sprite/Planet_left/Label.text = "Planeta ciepla ez"
	elif planeta[1] == "Trawa":
		$Sprite/Planet_left/Label.text = "Moze znajdziesz ziolka"
	elif planeta[1] == "Woda":
		$Sprite/Planet_left/Label.text = "Wez parasol"
	elif planeta[1] == "Prad":
		$Sprite/Planet_left/Label.text = "Lepiej nie bierz parasola "
	
	if planeta[2] == "Ogien":
		$Sprite/Planet_right/Label.text = "Planeta ciepla ez"
	elif planeta[2] == "Trawa":
		$Sprite/Planet_right/Label.text = "Moze znajdziesz ziolka"
	elif planeta[2] == "Woda":
		$Sprite/Planet_right/Label.text = "Wez parasol"
	elif planeta[2] == "Prad":
		$Sprite/Planet_right/Label.text = "Lepiej nie bierz parasola "
	

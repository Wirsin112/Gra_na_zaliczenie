extends Node2D
var save_path_planet = "user://Planet.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var save_path_misje = "user://Misje.dat"
var save_path_is_saved = "user://is_saved.dat"
var Save = 3
var start_set = [0,"Prad","Woda"]
var stat_set_curent = ["Ogien", 0]
var stat_set_misje = ["Walka","Las","Las"]
var Curent_planet
var planet
var misje
func _ready():
	check_save_planet()
	check_save_curent()
	check_save_misje()
	save_unique(Save,save_path_is_saved)
	if Curent_planet[1] == 4:
		$Sprite/Lewy/Label.text = "Boss"
		$Sprite/Prawo/Label.text = "Boss"
		$Sprite/Lewy.texture_normal = load("res://Zdarzenia/Boss.png")
		$Sprite/Prawo.texture_normal = load("res://Zdarzenia/Boss.png")
	else:
		wyswietl_misje()
		wyswietl_opis_misji()

func _on_Exit_pressed():
	$Sprite/Wiadomosc.rect_position = Vector2(-640,-360)
func save_planet(save):
	var file = File.new()
	var error = file.open(save_path_planet, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	
func load_planet():
	var file = File.new()
	if file.file_exists(save_path_planet):
		var error = file.open(save_path_planet, File.READ)
		if error == OK:
			planet = file.get_var()
			file.close()

func check_save_planet():
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
	load_planet()
	
func save_unique(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
			
func save_misje(save):
	var file = File.new()
	var error = file.open(save_path_misje, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	
func load_misje():
	var file = File.new()
	if file.file_exists(save_path_misje):
		var error = file.open(save_path_misje, File.READ)
		if error == OK:
			misje = file.get_var()
			file.close()

func check_save_misje():
	var file = File.new()
	if file.file_exists(save_path_misje):
		var error = file.open(save_path_misje, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(stat_set_misje)
			file.close()
	else:
		var error = file.open(save_path_misje, File.WRITE)
		if error == OK:
			file.store_var(stat_set_misje)
			file.close()
	load_misje()
func save_curent(save):
	var file = File.new()
	var error = file.open(save_path_planet_curent, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	
func load_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ)
		if error == OK:
			Curent_planet = file.get_var()
			file.close()			
func check_save_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(stat_set_curent)
			file.close()
	else:
		var error = file.open(save_path_planet_curent, File.WRITE)
		if error == OK:
			file.store_var(stat_set_curent)
			file.close()
	load_curent()


func _on_Zostan_pressed():
	$Sprite/Wiadomosc.rect_position = Vector2(640,-360)
func _on_Wroc_pressed():
	if Curent_planet[1] == 4:
		planet[0] = 0
	else:	
		planet[0] = 1
	save_planet(planet)
	get_tree().change_scene("res://Wyprawa_skrzynia.tscn")
func wyswietl_misje():
	$Sprite/Lewy.texture_normal = load("res://Zdarzenia/"+String(misje[0])+".png")
	$Sprite/Prawo.texture_normal = load("res://Zdarzenia/"+String(misje[1])+".png")
func wyswietl_opis_misji():
	if misje[0] == "Las":
		$Sprite/Lewy/Label.text = "Mozesz zdobyc tam spore ilosci drewna swieze wazywa i owoce. Jezli posiadasz siekiere mozesz zdobyc dodatkowe drewno"
	elif misje[0] == "Jezioro":
		$Sprite/Lewy/Label.text = "Mozesz tam zlowic ryby jesli posiadasz wedke i przy okazji zebrac troche wody. Przy okazji moze znajdziesz jakies warzywa"
	elif misje[0] == "Laka":
		$Sprite/Lewy/Label.text = "Mozesz zebrac tam nici z bawely male ilosci drewna badz warzywa"
	elif misje[0] == "Skala":
		$Sprite/Lewy/Label.text = "Mozesz zebrac tam zelazo, a jezeli posiadasz kilof i Ci sie poswieci jakies cory"
	elif misje[0] == "Walka":
		$Sprite/Lewy/Label.text = "O bogowie walka"
	if misje[1] == "Las":
		$Sprite/Prawo/Label.text = "Mozesz zdobyc tam spore ilosci drewna swieze wazywa i owoce. Jezli posiadasz siekiere mozesz zdobyc dodatkowe drewno"
	elif misje[1] == "Jezioro":
		$Sprite/Prawo/Label.text = "Mozesz tam zlowic ryby jesli posiadasz wedke i przy okazji zebrac troche wody. Przy okazji moze znajdziesz jakies warzywa"
	elif misje[1] == "Laka":
		$Sprite/Prawo/Label.text = "Mozesz zebrac tam nici z bawely male ilosci drewna badz warzywa"
	elif misje[1] == "Skala":
		$Sprite/Prawo/Label.text = "Mozesz zebrac tam zelazo, a jezeli posiadasz kilof i Ci sie poswieci jakies cory"
	elif misje[1] == "Walka":
		$Sprite/Prawo/Label.text = "O bogowie walka"
func przelosuj_misje():
	var los = randi()%5
	if los == 0:
		misje[0] = "Las"
	elif los == 1:
		misje[0] = "Jezioro"
	elif los == 2:
		misje[0] = "Laka"
	elif los == 3:
		misje[0] = "Skala"
	elif los == 4:
		misje[0] = "Walka"
	los = randi()%5
	if los == 0:
		misje[1] = "Las"
	elif los == 1:
		misje[1] = "Jezioro"
	elif los == 2:
		misje[1] = "Laka"
	elif los == 3:
		misje[1] = "Skala"
	elif los == 4:
		misje[1] = "Walka"

func _on_Lewy_pressed():
	misje[2] = misje[0]
	przelosuj_misje()
	save_misje(misje)
	wyswietl_misje()
	wyswietl_opis_misji()
	if Curent_planet[1] == 4:
		get_tree().change_scene("res://Boss.tscn")
	elif misje[2] == "Walka":
		get_tree().change_scene("res://Walka_Normalna.tscn")
	else:
		get_tree().change_scene("res://Test_zapisu.tscn")

func _on_Prawo_pressed():
	misje[2] = misje[1]
	przelosuj_misje()
	save_misje(misje)
	wyswietl_misje()
	wyswietl_opis_misji()
	if Curent_planet[1] == 4:
		get_tree().change_scene("res://res://Boss.tscn")
	elif misje[2] == "Walka":
		get_tree().change_scene("res://Walka_Normalna.tscn")
	else:
		get_tree().change_scene("res://Test_zapisu.tscn")

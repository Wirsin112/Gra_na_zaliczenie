extends Node2D
onready var timer = get_node("Timer")
var save_path_is_saved = "user://is_saved.dat"
var save_path = "user://save.dat"
var save_path_walka = "user://save_walka.dat"
var save_path_boss = "user://save_Boss.dat"
var save_path_planet = "user://Planet.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var save_path_Gracz = "user://hp.dat"
var save_path_misje = "user://Misje.dat"
var save_path_Zbroja= "user://Zbroja.dat"
var button = false
var check_save = 0;
var start_set = 0;
var misje;
var dir = Directory.new()
var start_Gracz = [100,100,100,0,200]
var start_planety = [0,"Trawa","Woda"]
var start_set_curent = ["Ogien",0]
var start_set_misje = ["Walka","Las","Las"]
var start_eq = {
	0:["Wood", 5],
	1:["RawPotato", 5],
	2:["japko_kilik", 1],
	3:["Zupa", 1],
	4:["Zupa", 1],
	5:["Empty",1],
	6:["Empty",1],
	7:["Empty",1],
	8:["Empty",1],
	9:["Empty",1]  
}
var start_zborja = {
	0:[0,0,0,0],
	1:[0,0,0,0],
	2:[0,0,0,0],
	3:[0,0,0,0],
	4:[0,0,0,0]
}
func _ready():
	check_save()
	timer.set_wait_time(2)

func _on_LGame_pressed():
	if check_save == 1:
		get_tree().change_scene("res://Main_Statek.tscn")
	elif check_save == 2:
		get_tree().change_scene("res://Test_zapisu.tscn")
	elif check_save == 3:
		get_tree().change_scene("res://Wyprawa.tscn")
	elif check_save == 4:
		get_tree().change_scene("res://Wyprawa_skrzynia.tscn")
	elif check_save == 5:
		get_tree().change_scene("res://Walka_Normalna.tscn")
	elif check_save == 6:
		get_tree().change_scene("res://Boss.tscn")
	elif check_save == 7:
		pass
	else:
		timer.start()
		get_node("LGame").text = "Brak Zapisanej Gry"
func _on_Samouczek_walki_pressed():
	get_tree().change_scene("res://Samouczek_Walki.tscn")
func _on_Samouczek_gry_pressed():
	get_node("Samouczek_gry").text = "WIP"


func _on_Timer_timeout():
	get_node("LGame").text = "Wczytaj Gre"
	timer.stop()
	get_node("LGame").pressed = false


func save_data(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(save_path_is_saved):
		var error = file.open(save_path_is_saved, File.READ)
		if error == OK:
			check_save = file.get_var()
			file.close()

func check_save():
	var file = File.new()
	if file.file_exists(save_path_is_saved):
		var error = file.open(save_path_is_saved, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path_is_saved, File.WRITE)
		if error == OK:
			file.store_var(start_set)
			file.close()
	load_data()


func _on_Tak_pressed():
	dir.remove(save_path)
	dir.remove(save_path_Gracz)
	dir.remove(save_path_is_saved)
	dir.remove(save_path_planet)
	dir.remove(save_path_planet_curent)
	dir.remove(save_path_misje)
	dir.remove(save_path_Zbroja)
	dir.remove(save_path_walka)
	dir.remove(save_path_boss)
	check_save = 1;
	save_data(start_Gracz,save_path_Gracz)
	save_data(start_planety,save_path_planet)
	save_data(start_set_curent,save_path_planet_curent)
	save_data(start_eq,save_path)
	save_data(start_set_misje,save_path_misje)
	save_data(check_save,save_path_is_saved)
	save_data(start_zborja,save_path_Zbroja)
	get_tree().change_scene("res://Main_Statek.tscn")
func _on_Nie_pressed():
	$Warning.rect_position = Vector2(1280,0)

func _on_NGame_pressed():
	if check_save == 0:
		dir.remove(save_path)
		dir.remove(save_path_Gracz)
		dir.remove(save_path_is_saved)
		dir.remove(save_path_planet)
		dir.remove(save_path_planet_curent)
		dir.remove(save_path_misje)
		dir.remove(save_path_Zbroja)
		dir.remove(save_path_walka)
		dir.remove(save_path_boss)
		check_save = 1;
		save_data(start_Gracz,save_path_Gracz)
		save_data(start_planety,save_path_planet)
		save_data(start_set_curent,save_path_planet_curent)
		save_data(start_eq,save_path)
		save_data(start_set_misje,save_path_misje)
		save_data(check_save,save_path_is_saved)
		save_data(start_zborja,save_path_Zbroja)
		get_tree().change_scene("res://Main_Statek.tscn")
	else:
		$Warning.rect_position = Vector2(0,0)

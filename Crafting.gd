extends Node2D
var Ilosc_drewna = 3
var Ilosc_nici = 0
var Ilosc_Cocked_Potato = 0
var Ilosc_Zelaza = 0
var Ilosc_Haczykow = 1
var Change_icon
var Change_skladnik
var Skladnik_jeden
var Skladnik_dwa
var Skladnik_trzy
var Ktory = 0
var Mozesz = 0
func _ready():
	pass
func _jeden_turn_off():
	Change_icon = preload("res://Hud/Empty.png")
	get_node("Background/Jeden_Skladnik/jeden").texture_normal = Change_icon
	get_node("Background/Jeden_Skladnik/need").text = " "
	get_node("Background/Jeden_Skladnik/ilosc1").text = " "
func _dwa_turn_off():
	Change_icon = preload("res://Hud/Empty.png")
	get_node("Background/Dwa_Skladniki/jeden").texture_normal = Change_icon
	get_node("Background/Dwa_Skladniki/dwa").texture_normal = Change_icon
	get_node("Background/Dwa_Skladniki/need").text = " "
	get_node("Background/Dwa_Skladniki/ilosc1").text = " "
	get_node("Background/Dwa_Skladniki/ilosc2").text = " "
func _trzy_turn_off():
	Change_icon = preload("res://Hud/Empty.png")
	get_node("Background/Trzy_Skladniki/jeden").texture_normal = Change_icon
	get_node("Background/Trzy_Skladniki/dwa").texture_normal = Change_icon
	get_node("Background/Trzy_Skladniki/trzy").texture_normal = Change_icon
	get_node("Background/Trzy_Skladniki/need").text = " "
	get_node("Background/Trzy_Skladniki/ilosc1").text = " "
	get_node("Background/Trzy_Skladniki/ilosc2").text = " "
	get_node("Background/Trzy_Skladniki/ilosc3").text = " "
func _jeden_skladniki(skladnik_jeden_obraz,skladnik_jeden_ilosc,skladnik_name):
	get_node("Background/Jeden_Skladnik/jeden").texture_normal = skladnik_jeden_obraz
	get_node("Background/Jeden_Skladnik/need").text = "Potrzebujesz tego skladnika rzeby stworzyc:" + skladnik_name
	get_node("Background/Jeden_Skladnik/ilosc1").text = skladnik_jeden_ilosc
func _dwa_skladniki(skladnik_jeden_obraz,skladnik_dwa_obraz,skladnik_jeden_ilosc,skladnik_dwa_ilosc,skladnik_name):
	get_node("Background/Dwa_Skladniki/jeden").texture_normal = skladnik_jeden_obraz
	get_node("Background/Dwa_Skladniki/dwa").texture_normal = skladnik_dwa_obraz
	get_node("Background/Dwa_Skladniki/need").text = "Potrzebujesz tych skladnikow zeby stworzyc:" + skladnik_name
	get_node("Background/Dwa_Skladniki/ilosc1").text = skladnik_jeden_ilosc
	get_node("Background/Dwa_Skladniki/ilosc2").text = skladnik_dwa_ilosc
func _trzy_skladniki(skladnik_jeden_obraz,skladnik_dwa_obraz,skladnik_trzy_obraz,skladnik_jeden_ilosc,skladnik_dwa_ilosc,skladnik_trzy_ilosc,skladnik_name):
	get_node("Background/Trzy_Skladniki/jeden").texture_normal = skladnik_jeden_obraz
	get_node("Background/Trzy_Skladniki/dwa").texture_normal = skladnik_dwa_obraz
	get_node("Background/Trzy_Skladniki/trzy").texture_normal = skladnik_trzy_obraz
	get_node("Background/Trzy_Skladniki/need").text = "Potrzebujesz tych skladnikow zeby stworzyc:" + skladnik_name
	get_node("Background/Trzy_Skladniki/ilosc1").text = skladnik_jeden_ilosc
	get_node("Background/Trzy_Skladniki/ilosc2").text = skladnik_dwa_ilosc
	get_node("Background/Trzy_Skladniki/ilosc3").text = skladnik_trzy_ilosc
func _mozesz_zrobic(Sprawdz):
	if Sprawdz == 0:
		if Ilosc_drewna >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	if Sprawdz == 1:
		if Ilosc_nici>= 3:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	if Sprawdz == 2:
		if Ilosc_nici>= 1 and Ilosc_Zelaza >= 1 and Ilosc_Cocked_Potato >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	if Sprawdz == 3:
		if Ilosc_Haczykow >= 1 and Ilosc_drewna >= 3:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
func _on_Przycisk_Miska_pressed():
	_dwa_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Food/PustaMiska.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Miska/Name").text
	Skladnik_jeden = preload("res://Material/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Miska/Name").text
	_jeden_skladniki(Skladnik_jeden,"1",Change_skladnik)
	Ktory = 0
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Szpula_pressed():
	_dwa_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Szpula.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Szpula/Name").text
	Skladnik_jeden = preload("res://Material/Nic.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Szpula/Name").text
	_jeden_skladniki(Skladnik_jeden,"3",Change_skladnik)
	Ktory = 1
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Przynenta_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Food/Bait.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Przynenta/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Food/ChestCookedPotato (1).png")
	Skladnik_trzy = preload("res://Material/Nic.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Przynenta/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"1","1","1",Change_skladnik)
	Ktory = 2
	_mozesz_zrobic(Ktory)
func _on_Przycisk_Wedka_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Wedka.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Wedka/Name").text
	Skladnik_jeden = preload("res://Food/Bait.png")
	Skladnik_dwa = preload("res://Material/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Przynenta/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"1","3",Change_skladnik)
	
	Ktory = 3
	_mozesz_zrobic(Ktory)
func _on_Exit_pressed():
	get_tree().change_scene("res://Main_Statek.tscn")

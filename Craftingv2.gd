extends Node2D
const NUM_INVENTORY_SLOTS = 78
var save_path = "user://save.dat"
var save_path_planet = "user://Planet.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var save_path_Zbroja= "user://Zbroja.dat"
var przedmioty
var Change_icon
var Change_skladnik
var Skladnik_jeden
var Skladnik_dwa
var Skladnik_trzy
var Ktory = 0
var Mozesz = 0
var Zbroja
var Czy_wolne_miejsce = 0
var Czy_dodano_przedmiot = 0
var index_y = 1
var index_x = 0
var Usuwanie = [0,0,0]
var Table_info = {
	0:["Wood",1],
	1:["Nic",3],
	2:["Iron","CookedPotato","Nic",1,1,2],
	3:["Bait","Wood",1,3],
	4:["Iron","Wood",3,2],
	5:["Iron","Wood",3,2],
	6:["Iron","Prad_core",2,1],
	7:["Iron","Szpula","Prad_core",4,1,1],
	8:["Iron","Szpula","Prad_core",3,1,1],
	9:["Iron","Prad_core",2,1],
	10:["Iron","Ogien_core",2,1],
	11:["Iron","Szpula","Ogien_core",4,1,1],
	12:["Iron","Szpula","Ogien_core",3,1,1],
	13:["Iron","Ogien_core",2,1],
	14:["Iron","Woda_core",2,1],
	15:["Iron","Szpula","Woda_core",4,1,1],
	16:["Iron","Szpula","Woda_core",3,1,1],
	17:["Iron","Woda_core",2,1],
	18:["Iron","Trawa_core",2,1],
	19:["Iron","Szpula","Trawa_core",4,1,1],
	20:["Iron","Szpula","Trawa_core",3,1,1],
	21:["Iron","Trawa_core",2,1],
}
var Craft_book = {
	0:["PustaMiska",1],
	1:["Szpula",1],
	2:["Bait",1],
	3:["Wedka",1],
	4:["Kilof",1],
	5:["Siekiera",1],
	6:["Helm Elektryczny",0],
	7:["Klata Elektryczna",0],
	8:["Spodnie Elektryczne",0],
	9:["Buty Elekryczne",0],
	10:["Helm Ognisty",0],
	11:["Klata Ognista",0],
	12:["Spodnie Ogniste",0],
	13:["Buty Ogniste",0],
	14:["Helm Woda",0],
	15:["Klata Wodna",0],
	16:["Spodnie Wodne",0],
	17:["Buty Wodne",0],
	18:["Helm Natura",0],
	19:["Klata Natura",0],
	20:["Spodnie Natura",0],
	21:["Buty Natura",0],
}
var Ilosc_skladnikow = {
	0:["Wood",0],
	1:["CookedPotato",0],
	2:["Nic",0],
	3:["Iron",0],
	4:["Bait",0],
	5:["Szpula",0],
	6:["Prad_core",0],
	7:["Ogien_core",0],
	8:["Woda_core",0],
	9:["Trawa_core",0],
}
var start_set = {
	0:["Wood", 1],
	1:["Wood", 1],
	2:["RawPotato", 5],
	3:["japko_kilik", 5],
	4:["JapkosSurowe", 10],
	5:["Wood", 10],
	6:["PustaMiska", 2],
	7:["Warzywa", 1],
	8:["Warzywa", 1],
	9:["Warzywa", 1],
	10:["Woda", 1],
	11:["Zupa", 1]     
}
func _ready():
	load_Eq()
	check_save()
	Zalduj_skladniki()
	
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
	get_node("Background/Jeden_Skladnik/need").text = "Potrzebujesz tego skladnika rzeby stworzyc:\n" + skladnik_name
	get_node("Background/Jeden_Skladnik/ilosc1").text = skladnik_jeden_ilosc
func _dwa_skladniki(skladnik_jeden_obraz,skladnik_dwa_obraz,skladnik_jeden_ilosc,skladnik_dwa_ilosc,skladnik_name):
	get_node("Background/Dwa_Skladniki/jeden").texture_normal = skladnik_jeden_obraz
	get_node("Background/Dwa_Skladniki/dwa").texture_normal = skladnik_dwa_obraz
	get_node("Background/Dwa_Skladniki/need").text = "Potrzebujesz tych skladnikow zeby stworzyc:\n" + skladnik_name
	get_node("Background/Dwa_Skladniki/ilosc1").text = skladnik_jeden_ilosc
	get_node("Background/Dwa_Skladniki/ilosc2").text = skladnik_dwa_ilosc
func _trzy_skladniki(skladnik_jeden_obraz,skladnik_dwa_obraz,skladnik_trzy_obraz,skladnik_jeden_ilosc,skladnik_dwa_ilosc,skladnik_trzy_ilosc,skladnik_name):
	get_node("Background/Trzy_Skladniki/jeden").texture_normal = skladnik_jeden_obraz
	get_node("Background/Trzy_Skladniki/dwa").texture_normal = skladnik_dwa_obraz
	get_node("Background/Trzy_Skladniki/trzy").texture_normal = skladnik_trzy_obraz
	get_node("Background/Trzy_Skladniki/need").text = "Potrzebujesz tych skladnikow zeby stworzyc:\n" + skladnik_name
	get_node("Background/Trzy_Skladniki/ilosc1").text = skladnik_jeden_ilosc
	get_node("Background/Trzy_Skladniki/ilosc2").text = skladnik_dwa_ilosc
	get_node("Background/Trzy_Skladniki/ilosc3").text = skladnik_trzy_ilosc

func _mozesz_zrobic(Sprawdz):
	if Sprawdz == 0:
		if Ilosc_skladnikow[0][1] >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 1:
		if Ilosc_skladnikow[2][1] >= 3:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 2:
		if  Ilosc_skladnikow[1][1] >= 1 and  Ilosc_skladnikow[2][1] >= 2 and  Ilosc_skladnikow[3][1] >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 3:
		if Ilosc_skladnikow[4][1] >= 1 and Ilosc_skladnikow[0][1]  >= 3:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 4:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[0][1]  >= 2:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 5:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[0][1]  >= 2:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 6:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[6][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 7:
		if Ilosc_skladnikow[3][1] >= 4 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[6][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 8:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[6][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 9:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[6][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 10:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[7][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 11:
		if Ilosc_skladnikow[3][1] >= 4 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[7][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 12:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[7][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 13:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[7][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 14:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[8][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 15:
		if Ilosc_skladnikow[3][1] >= 4 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[8][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 16:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[8][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 17:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[8][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 18:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[9][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 19:
		if Ilosc_skladnikow[3][1] >= 4 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[9][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 20:
		if Ilosc_skladnikow[3][1] >= 3 and Ilosc_skladnikow[5][1] >= 1 and Ilosc_skladnikow[9][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 21:
		if Ilosc_skladnikow[3][1] >= 2 and Ilosc_skladnikow[9][1]  >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
func _on_Przycisk_Miska_pressed():
	_dwa_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/PustaMiska.png")
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
	Change_icon = preload("res://Material/Haczyk.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Przynenta/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Food/ChestCookedPotato (1).png")
	Skladnik_trzy = preload("res://Material/Nic.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Przynenta/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"1","1","2",Change_skladnik)
	Ktory = 2
	_mozesz_zrobic(Ktory)
func _on_Przycisk_Wedka_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Wedka.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Wedka/Name").text
	Skladnik_jeden = preload("res://Material/Haczyk.png")
	Skladnik_dwa = preload("res://Material/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Wedka/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"1","3",Change_skladnik)
	Ktory = 3
	_mozesz_zrobic(Ktory)
func _on_Przycisk_Kilof_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Kilof.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Kilof/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Kilof/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"3","2",Change_skladnik)
	Ktory = 4
	_mozesz_zrobic(Ktory)
func _on_Przycisk_Siekiera_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Siekiera.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Siekiera/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Siekiera/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"3","2",Change_skladnik)
	Ktory = 5
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Helm_Elektryczny_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Helm_Elektryczny.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Helm_Elektryczny/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Prad_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Helm_Elektryczny/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 6
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Klata_Elektryczna_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Klata_Elektryczna.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Klata_Elektryczna/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Prad_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Klata_Elektryczna/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"4","1","1",Change_skladnik)
	Ktory = 7
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Spodnie_Elektryczne_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Spodnie_Elektryczne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Elektryczne/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Prad_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Elektryczne/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"3","1","1",Change_skladnik)
	Ktory = 8
	_mozesz_zrobic(Ktory)

func _on_Przysik_Buty_Elektryczne_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Buty_Elektryczne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Buty_Elektryczne/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Prad_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Buty_Elektryczne/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 9
	_mozesz_zrobic(Ktory)
	
	
	
func _on_Przycisk_Helm_Ogien_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Helm_Ognisty.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Helm_Ogien/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Ogien_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Helm_Ogien/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 10
	_mozesz_zrobic(Ktory)



func _on_Przycisk_Klata_Ogien_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Klata_Ognista.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Klata_Ogien/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Ogien_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Klata_Ogien/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"4","1","1",Change_skladnik)
	Ktory = 11
	_mozesz_zrobic(Ktory)


func _on_Przycisk_Spodnie_Oien_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Spodnie_Ogniste.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Ogien/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Ogien_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Ogien/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"3","1","1",Change_skladnik)
	Ktory = 12
	_mozesz_zrobic(Ktory)


func _on_Przycisk_Buty_Ogien_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Buty_Ogniste.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Buty_Ogien/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Ogien_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Buty_Ogien/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 13
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Helm_Woda_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Helm_Wodny.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Helm_Woda/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Woda_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Helm_Woda/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 14
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Klata_Woda_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Klata_Wodna.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Klata_Woda/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Woda_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Klata_Woda/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"4","1","1",Change_skladnik)
	Ktory = 15
	_mozesz_zrobic(Ktory)


func _on_Przycisk_Spodnie_Woda_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Spodnie_Wodne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Woda/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Woda_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Woda/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"3","1","1",Change_skladnik)
	Ktory = 16
	_mozesz_zrobic(Ktory)


func _on_Przycisk_Buty_Woda_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Buty_wodne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Buty_Woda/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Woda_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Buty_Woda/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 17
	_mozesz_zrobic(Ktory)



func _on_Przycisk_Helm_Natura_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Helm_Ziemny.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Helm_Natura/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Trawa_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Helm_Natura/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 18
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Klata_Natura_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Klata_Ziemna.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Klata_Natura/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Trawa_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Klata_Natura/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"4","1","1",Change_skladnik)
	Ktory = 19
	_mozesz_zrobic(Ktory)

func _on_Przycisk_Spodnie_Natura_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Material/Spodnie_Ziemne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Natura/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Szpula.png")
	Skladnik_trzy = preload("res://Material/Trawa_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Spodnie_Natura/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"3","1","1",Change_skladnik)
	Ktory = 20
	_mozesz_zrobic(Ktory)


func _on_Przycisk_Natura_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Material/Buty_Ziemne.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Buty_Natura/Name").text
	Skladnik_jeden = preload("res://Material/Iron.png")
	Skladnik_dwa = preload("res://Material/Trawa_core.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Buty_Natura/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"2","1",Change_skladnik)
	Ktory = 21
	_mozesz_zrobic(Ktory)
	
	

func save_data(save):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			przedmioty = file.get_var()
			file.close()
func check_save():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path, File.WRITE)
		if error == OK:
			file.store_var(start_set)
			file.close()
	load_data()
func save_Eq(save):
	var file = File.new()
	var error = file.open(save_path_Zbroja, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_Eq():
	var file = File.new()
	if file.file_exists(save_path_Zbroja):
		var error = file.open(save_path_Zbroja, File.READ)
		if error == OK:
			Zbroja = file.get_var()
			file.close()
func _on_Craft_check_pressed():
	if Mozesz == 1:
		if Ktory < 6:
			Sprawdz_czy_jest_wolne_miejsce()
			if Czy_wolne_miejsce == 1:
				Usun_Materialy(Table_info[Ktory])
				Dodaj_przedmiot_do_skrzyni()
				save_data(przedmioty)
				Zeruj_skladniki()
				Zalduj_skladniki()
				_mozesz_zrobic(Ktory)
				Czy_wolne_miejsce = 0
				$Background/Warning/W/blad.text = "Udalo Ci sie stworzyc " + Craft_book[Ktory][0]
				$Background/Warning.rect_position = Vector2(-640,-360)
			else:
				$Background/Warning/W/blad.text = "Brak wolnego mijesca zeby stworzyc " + Craft_book[Ktory][0]
				$Background/Warning.rect_position = Vector2(-640,-360)
		else:
			index_y = 1
			index_x = 0
			index_y += int((Ktory-6)/4)
			index_x = Ktory-6 - int((Ktory-6)/4)*4
			if Zbroja[index_y][index_x] == 0:
				Zbroja[index_y][index_x] = 1
				Usun_Materialy(Table_info[Ktory])
				save_data(przedmioty)
				save_Eq(Zbroja)
				Zeruj_skladniki()
				Zalduj_skladniki()
				_mozesz_zrobic(Ktory)
				Czy_wolne_miejsce = 0
				$Background/Warning/W/blad.text = "Udalo Ci sie stworzyc " + Craft_book[Ktory][0]
				$Background/Warning.rect_position = Vector2(-640,-360)
			else:
				$Background/Warning/W/blad.text = "Już stworzyles " + Craft_book[Ktory][0]
				$Background/Warning.rect_position = Vector2(-640,-360)
	else:
		$Background/Warning/W/blad.text = "Brakuje Ci skladnikow do zrobienia " + Craft_book[Ktory][0]
		$Background/Warning.rect_position = Vector2(-640,-360)
	Czy_dodano_przedmiot = 0
	Czy_wolne_miejsce = 0
func Sprawdz_czy_jest_wolne_miejsce():
	for i in NUM_INVENTORY_SLOTS:
		if przedmioty.has(i) and przedmioty[i][0] == Craft_book[Ktory][0] and przedmioty[i][1] < int(JsonData.item_data[Craft_book[Ktory][0]]["StackSize"]):
			Czy_wolne_miejsce = 1
			return
		if przedmioty.has(i) and przedmioty[i][0] == "Empty":
			Czy_wolne_miejsce = 1
			return
func Usun_Materialy(numer):
	for i in numer.size()/2:
		 Usuwanie[i] = numer[numer.size()/2+i]
	for i in numer.size()/2:
		for j in przedmioty.size():
			if przedmioty.has(j) and String(przedmioty[j][0]) == String(numer[i]) and przedmioty[j][1] > int(Usuwanie[i]):
				przedmioty[j][1] -= Usuwanie[i]
				Usuwanie[i] = 0
			elif przedmioty.has(j) and String(przedmioty[j][0]) == String(numer[i]) and przedmioty[j][1] == Usuwanie[i]:
				przedmioty[j][0] = "Empty"
				przedmioty[j][1] = 1
				Usuwanie[i] = 0
			elif przedmioty.has(j) and  String(przedmioty[j][0]) == String(numer[i]) and przedmioty[j][1] < Usuwanie[i]:
				przedmioty[j][0] = "Empty"
				Usuwanie[i] -= przedmioty[j][1]
				przedmioty[j][1] = 1
			if(Usuwanie[i] == 0):
				break
		for j in Ilosc_skladnikow.size():	
			if Ilosc_skladnikow.has(j) and String(Ilosc_skladnikow[j][0]) == String(numer[i]):
				Ilosc_skladnikow[j][1] -= numer[numer.size()/2+i]
func Dodaj_przedmiot_do_skrzyni():
	for i in NUM_INVENTORY_SLOTS:
		if przedmioty.has(i) and przedmioty[i][0] == Craft_book[Ktory][0] and przedmioty[i][1] < int(JsonData.item_data[Craft_book[Ktory][0]]["StackSize"]):
			przedmioty[i][1] += Craft_book[Ktory][1]
			Czy_dodano_przedmiot = 1
			return
	if Czy_dodano_przedmiot == 0:
		for i in NUM_INVENTORY_SLOTS:
			if przedmioty.has(i) and przedmioty[i][0] == "Empty":
				przedmioty[i][0] = Craft_book[Ktory][0]
				przedmioty[i][1] = Craft_book[Ktory][1]
				return	
func Zalduj_skladniki():
	for j in Ilosc_skladnikow.size():
		Ilosc_skladnikow[j][1] = 0
		for i in NUM_INVENTORY_SLOTS:
			if przedmioty.has(i) and przedmioty[i][0] == Ilosc_skladnikow[j][0]:
				Ilosc_skladnikow[j][1] += przedmioty[i][1]
func Zeruj_skladniki():
	for i in Ilosc_skladnikow.size():
		Ilosc_skladnikow[i][1] = 0
func _on_Button_pressed():
	$Background/Warning.rect_position = Vector2(640,0)
			
func _on_Exit_pressed():
	get_tree().change_scene("res://Main_Statek.tscn")

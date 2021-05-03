extends Node2D
const NUM_INVENTORY_SLOTS = 78
var save_path = "user://save.dat"
var przedmioty
var Change_icon
var Change_skladnik
var Skladnik_jeden
var Skladnik_dwa
var Skladnik_trzy
var Ktory = 0
var Mozesz = 0
var Czy_wolne_miejsce = 0
var Czy_dodano_przedmiot = 0
var Usuwanie = [0,0,0]
var Table_info = {
	0:["RawPotato","Wood", 1,1],
	1:["JapkosSurowe",1],
	2:["PustaMiska","Woda","Warzywa",1,1,3],
	3:["Zupa","Wood",1,2]
}
var Craft_book = {
	0:["CookedPotato",1],
	1:["japko_kilik",1],
	2:["Zupa",1],
	3:["ZupaCiepla",1]
}
var Ilosc_skladnikow = {
	0:["Wood",0],
	1:["RawPotato",0],
	2:["JapkosSurowe",0],
	3:["PustaMiska",0],
	4:["Zupa",0],
	5:["Warzywa",0],
	6:["Woda",0],
	
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
		if Ilosc_skladnikow[0][1] >= 1 and Ilosc_skladnikow[1][1] >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 1:
		if Ilosc_skladnikow[2][1] >= 1:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 2:
		if  Ilosc_skladnikow[3][1] >= 1 and  Ilosc_skladnikow[6][1] >= 1 and  Ilosc_skladnikow[5][1] >= 3:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
	elif Sprawdz == 3:
		if Ilosc_skladnikow[4][1] >= 1 and Ilosc_skladnikow[0][1]  >= 2:
			Mozesz = 1
			get_node("Background/Przycisk/Craft_check").text = "Mozesz Stworzyc"
		else:
			Mozesz = 0
			get_node("Background/Przycisk/Craft_check").text = "Nie Mozesz Stworzyc"
func _on_Przycisk_ziemniak_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Food/FoodCookedPotato.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Pieczony_Ziemniak/Name").text
	Skladnik_jeden = preload("res://Food/FoodRawPotato.png")
	Skladnik_dwa = preload("res://Food/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Pieczony_Ziemniak/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"1","1",Change_skladnik)
	Ktory = 0
	_mozesz_zrobic(Ktory)
func _on_Przycisk_Jabklo_pressed():
	_dwa_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Food/japko_kilik.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Pieczony_owoc/Name").text
	Skladnik_jeden = preload("res://Food/JapkosSurowe.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Pieczony_owoc/Name").text
	_jeden_skladniki(Skladnik_jeden,"1",Change_skladnik)
	Ktory = 1
	_mozesz_zrobic(Ktory)
func _on_Przycisk_zupa_pressed():
	_jeden_turn_off()
	_dwa_turn_off()
	Change_icon = preload("res://Food/Zupa.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Zupa_Warzywna/Name").text
	Skladnik_jeden = preload("res://Food/PustaMiska.png")
	Skladnik_dwa = preload("res://Food/Woda.png")
	Skladnik_trzy = preload("res://Food/Warzywa.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Zupa_Warzywna/Name").text
	_trzy_skladniki(Skladnik_jeden,Skladnik_dwa,Skladnik_trzy,"1","1","3",Change_skladnik)
	Ktory = 2
	_mozesz_zrobic(Ktory)
func _on_Przycisk_zupa_ciepla_pressed():
	_jeden_turn_off()
	_trzy_turn_off()
	Change_icon = preload("res://Food/ZupaCiepla.png")
	get_node("Background/Wyswietl/Ramka").texture_normal = Change_icon
	get_node("Background/Wyswietl/Nazwa").text = get_node("Background/ScrollContainer/VBoxContainer/Zupa_Warzywna_Ciepla/Name").text
	Skladnik_jeden = preload("res://Food/Zupa.png")
	Skladnik_dwa = preload("res://Food/FoodWood.png")
	Change_skladnik = get_node("Background/ScrollContainer/VBoxContainer/Zupa_Warzywna_Ciepla/Name").text
	_dwa_skladniki(Skladnik_jeden,Skladnik_dwa,"1","2",Change_skladnik)
	Ktory = 3
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
func _on_Craft_check_pressed():
	if Mozesz == 1:
		Sprawdz_czy_jest_wolne_miejsce()
		if Czy_wolne_miejsce == 1:
			Usun_Materialy(Table_info[Ktory])
			Dodaj_przedmiot_do_skrzyni()
			save_data(przedmioty)
			Zeruj_skladniki()
			Zalduj_skladniki()
			_mozesz_zrobic(Ktory)
			$Background/Warning/W/blad.text = "Udalo Ci sie stworzyc " + Craft_book[Ktory][0]
			$Background/Warning.rect_position = Vector2(-640,-360)
		else:
			$Background/Warning/W/blad.text = "Brak wolnego mijesca zeby stworzyc " + Craft_book[Ktory][0]
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
				przedmioty[j][1] = 0
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

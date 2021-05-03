extends Node2D

const SlotClass = preload("res://Slot1.gd")
var ItemClass = preload("res://Item.tscn")
onready var inventory_slots = $GridContainer
var holding_item = null
const NUM_INVENTORY_SLOTSv2 = 78
var save_path_wyprawa = "user://save_wyprawa.dat"
var save_path_Gracz = "user://hp.dat"
var save_path_wylosowane = "user://wylosowane.dat"
var save_path_misje = "user://Misje.dat"
var save_path_planet_curent = "user://Planet_curent.dat"
var save_path_is_saved = "user://is_saved.dat"
var Save = 2
var misje
var siekiera = 0
var kilof = 0
var wedka = 0
var Gracz
var food_max = 100
var dir = Directory.new()
var curent
var start_drop = {
	0:["Wood",1],
	1:["Iron",4],
	2:["Empty",1],
	3:["Empty",1],	
	4:["Empty",1],
	5:["Empty",1]
}
var drop
var inventoryv2={
}
var curent_slot
var start_set = {
	0:["Wood",1],
	1:["Empty",1],
	2:["Empty",1],
	3:["Empty",1],	
	4:["Empty",1],
	5:["Empty",1],
	6:["Empty",1],
	7:["Empty",1],	
	8:["Empty",1],
	9:["Empty",1],
	10:["Empty",1],
	11:["Empty",1],	
	12:["Empty",1],
	13:["Empty",1],
	14:["Empty",1],
	15:["Empty",1],	
	16:["Empty",1],
	17:["Empty",1],
	18:["Empty",1],
	19:["Empty",1],	
}

func _ready():
	dir.remove(save_path_wylosowane)
	load_curent()
	check_save()
	sprawdz_narzedzia()
	load_gracz()
	load_misje()
	losuj_przedmioty()
	check_drop()
	save_unique(Save,save_path_is_saved)
	$TextureRect/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
	$TextureRect/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
	$TextureRect/Gracz/Hp.max_value = Gracz[1]
	$TextureRect/Gracz/Food.max_value = 100
	$TextureRect/Gracz/Hp.value = Gracz[0]
	$TextureRect/Gracz/Food.value = Gracz[2]
	if Gracz[2] >= 5:
		Gracz[2] -= 5
	else:
		Gracz[0] -= 5
	set_hp_food()
	initialize_drop()
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self,"slot_gui_input", [inv_slot])
	initialize_inventory()
func slot_gui_input(event: InputEvent, slot : SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
					update_array(inventoryv2)
				else:
					if holding_item.item_name != slot.item.item_name:
						left_click_diffrent_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed:
			if holding_item == null:
				right_click_not_holding(slot)
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in  range(slots.size()-6):
		if inventoryv2.has(i) and inventoryv2[i][0] != "Empty":
			slots[i].initialize_item(inventoryv2[i][0], inventoryv2[i][1]) 
func initialize_drop():
	var slots = inventory_slots.get_children()
	var licznik = 0
	for i in range(20,slots.size()):
		if drop[licznik][0] != "Empty":
			slots[i].initialize_item(drop[licznik][0], drop[licznik][1]) 
		licznik += 1		
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func left_click_empty_slot(slot: SlotClass):
	slot.putIntoSlot(holding_item)
	holding_item = null

func left_click_diffrent_item(event: InputEvent, slot: SlotClass):
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(holding_item)
	holding_item = temp_item
	
func left_click_same_item(slot: SlotClass):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= holding_item.item_quantity:
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
		update_array(inventoryv2)
	else:
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)

func left_click_not_holding(slot: SlotClass):
	holding_item = slot.item
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()
func right_click_not_holding(slot):
	if slot.item != null:
		var chceck = int(JsonData.item_data[slot.item.item_name]["Useable"])	
		if chceck == 1:
			curent_slot = slot
			$Sprite/Warning/W/Zjedz.disabled = 0
			$Sprite/Warning/W/Zjedz.text = "Zjedz"
			$Sprite/Warning.rect_position = Vector2(0,0)
		if chceck ==  0:
			curent_slot = slot
			$Sprite/Warning/W/Zjedz.disabled = 1 
			$Sprite/Warning/W/Zjedz.text = "Nie mozesz tego zjesc"
			$Sprite/Warning.rect_position = Vector2(0,0)
func load_curent():
	var file = File.new()
	if file.file_exists(save_path_planet_curent):
		var error = file.open(save_path_planet_curent, File.READ)
		if error == OK:
			curent = file.get_var()
			file.close()
			

func load_misje():
	var file = File.new()
	if file.file_exists(save_path_misje):
		var error = file.open(save_path_misje, File.READ)
		if error == OK:
			misje = file.get_var()
			file.close()
			
func save_data(save):
	var file = File.new()
	var error = file.open(save_path_wyprawa, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_data():
	var file = File.new()
	if file.file_exists(save_path_wyprawa):
		var error = file.open(save_path_wyprawa, File.READ)
		if error == OK:
			inventoryv2 = file.get_var()
			file.close()
func check_save():
	var file = File.new()
	if file.file_exists(save_path_wyprawa):
		var error = file.open(save_path_wyprawa, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_set)
			file.close()
	else:
		var error = file.open(save_path_wyprawa, File.WRITE)
		if error == OK:
			file.store_var(start_set)
			file.close()
	load_data()

func save_drop(save):
	var file = File.new()
	var error = file.open(save_path_wylosowane, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_drop():
	var file = File.new()
	if file.file_exists(save_path_wylosowane):
		var error = file.open(save_path_wylosowane, File.READ)
		if error == OK:
			drop = file.get_var()
			file.close()
func check_drop():
	var file = File.new()
	if file.file_exists(save_path_wylosowane):
		var error = file.open(save_path_wylosowane, File.READ_WRITE)
		if error == OK:
			if file.get_var() == null:
				file.store_var(start_drop)
			file.close()
	else:
		var error = file.open(save_path_wylosowane, File.WRITE)
		if error == OK:
			file.store_var(start_drop)
			file.close()
	load_drop()
	
func save_unique(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	

func save_gracz(save):
	var file = File.new()
	var error = file.open(save_path_Gracz, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
	
func load_gracz():
	var file = File.new()
	if file.file_exists(save_path_Gracz):
		var error = file.open(save_path_Gracz, File.READ)
		if error == OK:
			Gracz = file.get_var()
			file.close()
func update_array(array):
	var slots = inventory_slots.get_children()
	for i in range(20):
		if slots[i].item == null:
			array[i] = ["Empty",1]
		else:
			array[i] = [slots[i].item.item_name,slots[i].item.item_quantity]
	save_data(inventoryv2)
func losuj_przedmioty():
	var los = randi()%2	
	if misje[2] == "Las":
		if(siekiera == 1):
			start_drop[0][0] = "Wood"
			start_drop[0][1] = 4
		else:
			start_drop[0][0] = "Wood"
			start_drop[0][1] = 2 
		start_drop[1][0] = "JapkosSurowe"
		start_drop[1][1] = 1
		start_drop[2][0] = "JapkosSurowe"
		start_drop[2][1] = 1
		start_drop[3][0] = "Warzywa"
		start_drop[3][1] = 4
		start_drop[4][0] = "Empty"
		start_drop[4][1] = 1
		start_drop[5][0] = "Empty"
		start_drop[5][1] = 1
	elif misje[2] == "Jezioro":
		if(wedka == 1):
			start_drop[5][0] = "Ryba"
			start_drop[5][1] = 1
		else:
			start_drop[5][0] = "Empty"
			start_drop[5][1] = 1 
		start_drop[0][0] = "Woda"
		start_drop[0][1] = 2
		start_drop[1][0] = "Warzywa"
		start_drop[1][1] = 2
		start_drop[2][0] = "RawPotato"
		start_drop[2][1] = 1
		start_drop[3][0] = "Empty"
		start_drop[3][1] = 1
		start_drop[4][0] = "Empty"
		start_drop[4][1] = 1
	elif misje[2] == "Laka":
		start_drop[0][0] = "Nic"
		start_drop[0][1] = 2 
		start_drop[1][0] = "RawPotato"
		start_drop[1][1] = 2
		start_drop[2][0] = "JapkosSurowe"
		start_drop[2][1] = 1
		start_drop[3][0] = "Warzywa"
		start_drop[3][1] = 4
		start_drop[4][0] = "Empty"
		start_drop[4][1] = 1
		start_drop[5][0] = "Empty"
		start_drop[5][1] = 1
	elif misje[2] == "Skala":
		var test = randi()%2
		if kilof == 1:
			start_drop[0][0] = "Iron"
			start_drop[0][1] = 4
		else:
			start_drop[0][0] = "Iron"
			start_drop[0][1] = 1 
		start_drop[1][0] = "Nic"
		start_drop[1][1] = 1
		if kilof == 1:
			var zmienna = " "
			zmienna = curent[0]
			zmienna += "_core"
			start_drop[2][0] = zmienna
			start_drop[2][1] = 1
		else:
			start_drop[2][0] = "Empty"
			start_drop[2][1] = 1
		start_drop[3][0] = "Empty"
		start_drop[3][1] = 1
		start_drop[4][0] = "Empty"
		start_drop[4][1] = 1
		start_drop[5][0] = "Empty"
		start_drop[5][1] = 1
	elif misje[2] == "Walka":
		pass
func sprawdz_narzedzia():
	for i in 20:
			if inventoryv2.has(i) and inventoryv2[i][0] == "Wedka":
				wedka = 1
			if inventoryv2.has(i) and inventoryv2[i][0] == "Kilof":
				kilof = 1
			if inventoryv2.has(i) and inventoryv2[i][0] == "Siekiera":
				siekiera = 1

func _on_Exit_pressed():
	if(holding_item == null):
		update_array(inventoryv2)
	save_data(inventoryv2)
	get_tree().change_scene("res://Wyprawa.tscn")


func _on_Wroc_pressed():
	$Sprite/Warning.rect_position = Vector2(1280,0)
	

func _on_Usun_pressed():
	curent_slot.item.decrease_item_quantity(100)
	curent_slot.delete()
	update_array(inventoryv2)
	load_data()
	$Sprite/Warning.rect_position = Vector2(1280,0)

func _on_Zjedz_pressed():
	Gracz[2] += int(JsonData.item_data[curent_slot.item.item_name]["Food"])
	if Gracz[2] <= 100:
		set_hp_food()
		save_gracz(Gracz)
	else:
		Gracz[2] = 100
		set_hp_food()
		save_gracz(Gracz)
	curent_slot.item.decrease_item_quantity(100)
	curent_slot.delete()
	update_array(inventoryv2)
	load_data()
	$Sprite/Warning.rect_position = Vector2(1280,0)
func set_hp_food():
	if Gracz[0] <= 0:
		save_gracz(Gracz)
		get_tree().change_scene("res://Death.tscn")
	else:
		$TextureRect/Gracz/Hp.value = Gracz[0]
		$TextureRect/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
		$TextureRect/Gracz/Food.value = Gracz[2]
		$TextureRect/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
		save_gracz(Gracz)

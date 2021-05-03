extends Node2D

const SlotClass = preload("res://Slot1.gd")
var ItemClass = preload("res://Item.tscn")
onready var inventory_slots = $GridContainer
var holding_item = null
const NUM_INVENTORY_SLOTSv2 = 78
var save_path = "user://save.dat"
var save_path_Gracz = "user://hp.dat"
var save_path_Misje = "user://misje.dat"
var inventoryv2
var curent_slot
var odnowienie
var Gracz
var hp_max = 100
var food_max = 100
var start_set = {
	0:["Wood", 5],
	1:["RawPotato", 5],
	2:["japko_kilik", 1],
	3:["Zupa", 1],
	4:["Zupa", 1]    
}

func _ready():
	check_save()
	load_gracz()
	$TextureRect/Gracz/Hp/numer_hp.text = String(Gracz[0]) + "/" + String(Gracz[1])
	$TextureRect/Gracz/Food/numer_food.text = String(Gracz[2]) + "/" + String(100)
	$TextureRect/Gracz/Hp.max_value = Gracz[1]
	$TextureRect/Gracz/Food.max_value = 100
	$TextureRect/Gracz/Hp.value = Gracz[0]
	$TextureRect/Gracz/Food.value = Gracz[2]
	set_hp_food()
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
	for i in  range(slots.size()):
		if inventoryv2.has(i) and inventoryv2[i][0] != "Empty":
			slots[i].initialize_item(inventoryv2[i][0], inventoryv2[i][1]) 

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
			odnowienie = int(JsonData.item_data[slot.item.item_name]["Food"])	
			curent_slot = slot
			$Sprite/Warning/W/Zjedz.disabled = 0
			$Sprite/Warning/W/Zjedz.text = "Zjedz"
			$Sprite/Warning.rect_position = Vector2(0,0)
		if chceck ==  0:
			curent_slot = slot
			$Sprite/Warning/W/Zjedz.disabled = 1 
			$Sprite/Warning/W/Zjedz.text = "Nie mozesz tego zjesc"
			$Sprite/Warning.rect_position = Vector2(0,0)	
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
			inventoryv2 = file.get_var()
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
func update_array(array):
	var slots = inventory_slots.get_children()
	for i in range(NUM_INVENTORY_SLOTSv2):
		if slots[i].item == null:
			array[i] = ["Empty",1]
		else:
			array[i] = [slots[i].item.item_name,slots[i].item.item_quantity]
	save_data(inventoryv2)

func _on_Exit_pressed():
	if(holding_item == null):
		update_array(inventoryv2)
	get_tree().change_scene("res://Main_Statek.tscn")
	
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

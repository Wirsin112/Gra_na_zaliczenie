extends Node2D

const SlotClass = preload("res://Slot1.gd")
var ItemClass = preload("res://Item.tscn")
onready var inventory_slots = $GridContainer
var holding_item = null
const NUM_INVENTORY_SLOTSv2 = 78
var save_path = "user://save.dat"
var save_path_inventory = "user://save_wyprawa.dat"
var save_path_is_saved = "user://is_saved.dat"
var Save = 4
var inventoryv2
var tab
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
var dir = Directory.new()
func _ready():
	check_save()
	load_eq()
	save_unique(Save,save_path_is_saved)
	
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self,"slot_gui_input", [inv_slot])
	initialize_inventory()
	initialize_eq()
	
func slot_gui_input(event: InputEvent, slot : SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					if holding_item.item_name != slot.item.item_name:
						left_click_diffrent_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)
	
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in  range(slots.size()):
		if inventoryv2.has(i) and inventoryv2[i][0] != "Empty":
			slots[i].initialize_item(inventoryv2[i][0], inventoryv2[i][1]) 
func initialize_eq():
	var slots = inventory_slots.get_children()
	var licznik = 0
	for i in  range(78,slots.size()):
		if tab.has(licznik) and tab[licznik][0] != "Empty":
			slots[i].initialize_item(tab[licznik][0], tab[licznik][1]) 
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
	else:
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)

func left_click_not_holding(slot: SlotClass):
	holding_item = slot.item
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()
	
func save_unique(save,save_path):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()	
		
func save_data(save):
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()
		
func save_eq(save):
	var file = File.new()
	var error = file.open(save_path_inventory, File.WRITE)
	if error == OK:
		file.store_var(save)
		file.close()

func load_eq():
	var file = File.new()
	if file.file_exists(save_path_inventory):
		var error = file.open(save_path_inventory, File.READ)
		if error == OK:
			tab = file.get_var()
			file.close()
func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			inventoryv2 = file.get_var()
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
func update_invetory(array):
	var licznik = 0
	var slots = inventory_slots.get_children()
	for i in range(NUM_INVENTORY_SLOTSv2,NUM_INVENTORY_SLOTSv2+20):
		if slots[i].item == null:
			array[licznik] = ["Empty",1]
			licznik+=1
		else:
			array[licznik] = [slots[i].item.item_name,slots[i].item.item_quantity]
			licznik+=1
	save_eq(tab)


func _on_Wyrusz_pressed():
	update_array(inventoryv2)
	dir.remove(save_path_inventory)
	get_tree().change_scene("res://Main_Statek.tscn")

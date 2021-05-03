extends Panel
var default_tex = preload("res://Hud/ChestTile64x64.png")
var empty_tex = preload("res://Hud/ChestEmptyTile64x64.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Item.tscn")
var item = null

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	refresh_style()
	
func refresh_style():
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set('custom_styles/panel', default_style)
func delete():
	item = null
	refresh_style()
func eat():
	if item.item_quantity == 1:
		delete()
	else:
		item.item_quantity -=1
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Skrzynia")
	inventoryNode.add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("Skrzynia")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()
	
func initialize_item(item_name,item_quantity):
	if(item == null):
		item = ItemClass.instance()
		var inventoryNode = find_parent("Skrzynia/Tutaj")
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name,item_quantity)
	refresh_style()
		


extends Node2D
var item_name
var item_quantity

func _ready():
	pass

func set_item(nm, qt):
		item_name = nm
		item_quantity = qt
		$TextureRect.texture = load("res://Skrzynia/" + item_name + ".png")
		
		var stack_size = int(JsonData.item_data[item_name]["StackSize"])
		if stack_size == 1:
			$Label.percent_visible = 0
		else:
			$Label.percent_visible = 1
			$Label.text = String(item_quantity)
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	if item_quantity >= 0:
		$Label.text = String(item_quantity)
	else:
		$TextureRect.texture = null
		$Label.text = ""
	

extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "Iron Sword"
	elif rand_val == 1:
		item_name = "Tree Branch"
	else :
		item_name = "Slime Potion"
		
	
	$Item.texture = load("res://Sprites/Inventory Sprites/Inventory Items/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$ItemNumber.visible = false
	else :
		$ItemNumber.text = String(item_quantity)
		
func set_item(nm, qt):
	item_name = nm
	item_quantity = qt
	$Item.texture = load("res://Sprites/Inventory Sprites/Inventory Items/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$ItemNumber.visible = false
	else :
		$ItemNumber.visible = true
		$ItemNumber.text = String(item_quantity)
	
func add_item_quantity(ammount_to_add):
	item_quantity += ammount_to_add
	$ItemNumber.text = String(item_quantity)
	
func decrease_item_quantity(ammount_to_remove):
	item_quantity -= ammount_to_remove
	$ItemNumber.text = String(item_quantity)

extends Node

@onready var time_elapsed:int = 0
@onready var first_child:Node
@onready var second_child:Node
@onready var index_int:int = 0
@onready var index_modulo:int
@onready var i_waited:bool = false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait_for(2)
	var i_waited = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if i_waited:
		time_elapsed += 1
	
	if (time_elapsed % 120) == 0:
		index_int += 1
		index_modulo = index_int % 2
		first_child = $"group-1".get_child(index_modulo)
		second_child = $"group-2".get_child(index_modulo)
		print_children()
	
	pass


func wait_for(time:int):
	await get_tree().create_timer(time).timeout
	pass

func print_children():
	if first_child.is_in_group("sphere"):
		print("first child is sphere")
	elif first_child.is_in_group("cube"):
		print("first child is cube")
		
	if second_child.is_in_group("sphere"):
		print("first child is sphere")
	elif second_child.is_in_group("cube"):
		print("first child is cube")
		
	print("...")

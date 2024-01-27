extends Node

class_name waiter

@onready var i_waited:bool = false	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func wait(time:float = 0):
	await get_tree().create_timer(1 + time).timeout
	i_waited = true
	pass

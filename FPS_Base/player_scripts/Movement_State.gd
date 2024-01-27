extends Node

@onready var movement_state:Lazy_State = Lazy_State.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	
func set_condition():
	movement_state.set_condition(Global.player.get_velocity().is_zero_approx())

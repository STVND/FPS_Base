extends Node3D

@export var explosion_speed:float = 10
@export var min_frag_lifetime:float = 10
@export var max_frag_lifetime:float = 20

@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		explode()
	pass
	
	

func explode():
	queue_free()
	for child in $destroyed_cube.get_children():
			if child is MeshInstance3D:
				var frag:Fragment = preload("res://fragment.tscn").instantiate()
				frag.init_from_main(child)
				frag.set_collision_layer_value(1, true)
				frag.set_collision_mask_value(1, true)
				frag.set_collision_layer_value(2, true)
				frag.set_collision_mask_value(2, true)
				parent.add_child(frag)
				
				var frag_impulse:Vector3 = Vector3(frag.global_position) - Vector3($explosion_origin.global_position)
				frag_impulse = frag_impulse.normalized()
				frag_impulse *= explosion_speed
				frag_impulse *= ((randi() % 15) / 10) + .5
				
				frag.apply_impulse(frag_impulse)
				

extends Node3D

@export var min_frag_lifetime:float = 10
@export var max_frag_lifetime:float = 20

@onready var destroyed_object:Node3D = $destroyed_object.get_child(0)

@onready var parent = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wait(.1)
	pass

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	$destroyed_object.visible = false
	create_destructible()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	


func create_destructible():
	for child in destroyed_object.get_children():
			if child is MeshInstance3D:
				var frag:Fragment = preload("res://fragment.tscn").instantiate()
				frag.init_from_main(child)
				frag.set_collision_layer_value(1, true)
				frag.set_collision_mask_value(1, true)
				frag.set_collision_layer_value(2, true)
				frag.set_collision_mask_value(2, true)
				frag.set_sleeping(true)
				frag.add_to_group("destructible")
				#frag.wall_health.set_res(1)
				parent.add_child(frag)

extends Node3D

@onready var bullet_body = $MeshInstance3D/Area3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_body.set_contact_monitor = true
	bullet_body.set_max_contacts_reported = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.

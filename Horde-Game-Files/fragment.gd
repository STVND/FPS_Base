extends RigidBody3D
class_name Fragment

@export var lifetime:float = 1
var elapsed_time:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_linear_damp(.5)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	elapsed_time += delta
	
	if elapsed_time > lifetime:
		if self.is_sleeping() == false:
			self.set_sleeping(true)
		if self.collision_layer == 1:
			self.set_collision_layer_value(1, false)
			self.set_collision_mask_value(1, false)
			self.set_collision_layer_value(3, true)
			self.set_collision_mask_value(3, true)
			
		
func init_from_main(source:MeshInstance3D):
	global_transform = source.global_transform
	
	var mesh_inst:MeshInstance3D = source.duplicate()
	mesh_inst.transform = Transform3D.IDENTITY
	add_child(mesh_inst)
	
	$CollisionShape3D.shape = source.mesh.create_trimesh_shape()
	

extends RigidBody3D
class_name Fragment

@export var explosion_speed:float = 10
@export var lifetime:float = 1
@onready var elapsed_time:float = 0
@onready var wall_health:General_Resource = General_Resource.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_linear_damp(.5)
	wall_health.set_max_res(0)
	wall_health.set_res(0)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !is_freeze_enabled():
		elapsed_time += delta

			
	
	if elapsed_time > lifetime:
		if !self.sleeping:
			set_sleeping(true)
			PROCESS_MODE_DISABLED
			self.set_collision_layer_value(1, false)
			self.set_collision_mask_value(1, false)


			
		
func init_from_main(source:MeshInstance3D):
	global_transform = source.global_transform
	
	var mesh_inst:MeshInstance3D = source.duplicate()
	mesh_inst.transform = Transform3D.IDENTITY

	add_child(mesh_inst)
	
	$CollisionShape3D.shape = source.mesh.create_convex_shape()
	$CollisionShape3D.shape.margin = .001
	
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	set_freeze_enabled(true)
	
	set_sleeping(true)
	
func hit(expl_normal:Vector3, bull_dam:int):
	if wall_health.get_res() == 0:
		
		
		var frag_impulse: Vector3 = expl_normal
		frag_impulse = frag_impulse.normalized()
		frag_impulse *= explosion_speed
		frag_impulse *= ((randi() % 15) / 10) + .5
		set_freeze_enabled(false)
		apply_impulse(frag_impulse)
		apply_torque_impulse(Vector3(randfn(-PI,PI),randfn(-PI,PI),randfn(-PI,PI)))


		
	else:
		wall_health.sub_res(bull_dam)
	

	print(wall_health.get_res())

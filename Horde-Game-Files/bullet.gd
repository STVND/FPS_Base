extends Node3D
class_name Bullet

@export var damage: int = 10
@export var lifetime: int = 1
@export var sphere_diameter: float = 1

@onready var bullet_body = $MeshInstance3D/Area3D/CollisionShape3D
@onready var direction: Vector3 = Vector3.ZERO
@onready var speed: float = 20	

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var hit_object


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -speed) * delta
	
	if ray.is_colliding():
		mesh.visible = false
		queue_free()
		if ray.get_collider().is_in_group("destructible"):
			
			ray.get_collider().hit(ray.get_collision_normal(), damage)
			pass
		
	
	var current_life: int = 0
	current_life += 1
	if (current_life > lifetime):
		print("deleting bullet")
		queue_free()
	


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
